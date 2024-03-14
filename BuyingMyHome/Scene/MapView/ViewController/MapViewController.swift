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

	override func configureBinding() {
		viewModel.tapMapOutPut.bind { [weak self] result in
			print(result)
			self?.mapView.configureUI(result)
			self?.mapView.isInfoViewAppear(true)
		}
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
