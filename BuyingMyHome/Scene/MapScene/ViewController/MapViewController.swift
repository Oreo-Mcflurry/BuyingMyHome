//
//  MapViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/13/24.
//

import UIKit
import NMapsMap
import SnapKit

final class MapViewController: BaseViewController {
	let viewModel = MapViewModel()
	let mapView = MapView()

	override func loadView() {
		self.view = mapView
	}

	override func viewWillAppear(_ animated: Bool) {
		self.tabBarController?.tabBar.isHidden = false
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setMapView()
	}

	override func configureView() {
		mapView.infoView.cancelButton.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
		mapView.searchButton.addTarget(self, action: #selector(tapSearchButton), for: .touchUpInside)
		mapView.infoView.addButton.addTarget(self, action: #selector(tapAddEditButton), for: .touchUpInside)
	}

	override func configureBinding() {
		viewModel.tapMapOutPut.bind { [weak self] result in
			self?.mapView.configureUI(result)
			self?.mapView.isInfoViewAppear(true)
		}

		viewModel.cancelButtonOutput.bind { [weak self] _ in
			self?.mapView.isInfoViewAppear(false)
		}

		viewModel.searchButtonOutput.bind { [weak self] _ in
			let vc = SearchViewController()
			vc.completionHandler = { value in
				self?.viewModel.searchResultInput.value = value
			}
			self?.navigationController?.pushViewController(vc, animated: true)
		}

		viewModel.searchResultOutput.bind { [weak self] value in
			guard let value else { return }
			let latlng = NMGLatLng(lat: value.lat, lng: value.lng)

			self?.mapView.configureUI((value.symbol, value.address))
			self?.viewModel.searchMarker(self!.mapView.naverMap.mapView, latlng: latlng)
			self?.mapView.isInfoViewAppear(true)
		}

		viewModel.addEditbuttonOutput.bind { [weak self] _ in
			let vc = AddEditViewController()
			self?.navigationController?.pushViewController(vc, animated: true)
		}
	}

	@objc private func tapCancelButton() {
		viewModel.cancelButtonInput.value = ()
	}

	@objc private func tapSearchButton() {
		viewModel.searchButtonInput.value = ()
	}

	@objc private func tapAddEditButton() {
		viewModel.addEditbuttonInput.value = ()
	}
}

extension MapViewController: NMFMapViewTouchDelegate {

	private func setMapView() {
		mapView.naverMap.mapView.touchDelegate = self
	}

	func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
		viewModel.tapSymbol(mapView, didTap: symbol)
		return true
	}
}
