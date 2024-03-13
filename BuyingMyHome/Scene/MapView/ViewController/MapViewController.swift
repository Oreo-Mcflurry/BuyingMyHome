//
//  MapViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/13/24.
//

import UIKit
import NMapsMap
import SnapKit

class MapViewController: BaseViewController {
	let mapView = MapView()

	override func loadView() {
		self.view = mapView
		mapView.naverMap.mapView.touchDelegate = self
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}


extension MapViewController: NMFMapViewTouchDelegate {
	func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
		print(latlng)
	}
}
