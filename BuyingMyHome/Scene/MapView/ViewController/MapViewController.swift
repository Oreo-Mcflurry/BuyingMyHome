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

	override func viewDidLoad() {
		super.viewDidLoad()
		setMapView()
	}

	override func configureView() {
		mapView.infoView.cancelButton.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
		mapView.searchButton.addTarget(self, action: #selector(tapSearchButton), for: .touchUpInside
		)
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

			self?.mapView.configureUI((value.addressName, value.placeName))
			self?.viewModel.searchMarker(self!.mapView.naverMap.mapView, latlng: latlng)
			self?.self.mapView.naverMap.mapView.moveCamera(NMFCameraUpdate(scrollTo: latlng))
			self?.mapView.isInfoViewAppear(true)
		}
	}

	@objc private func tapCancelButton() {
		viewModel.cancelButtonInput.value = ()
	}

	@objc private func tapSearchButton() {
		viewModel.searchButtonInput.value = ()
	}
}

extension MapViewController: NMFMapViewTouchDelegate {

	private func setMapView() {
		mapView.naverMap.mapView.touchDelegate = self
	}

	func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
		viewModel.tapMap(mapView, latlng: latlng)
	}

	func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
		viewModel.tapSymbol(mapView, didTap: symbol)
		return true
	}
}