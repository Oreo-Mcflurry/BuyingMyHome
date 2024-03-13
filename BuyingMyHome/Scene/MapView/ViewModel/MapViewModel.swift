//
//  MapViewModel.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/13/24.
//

import Foundation
import NMapsMap

final class MapViewModel {
	

	func tapMapMakeMarker(_ mapView: NMFMapView, latlng: NMGLatLng) {
		let marker = NMFMarker()
		marker.position = NMGLatLng(lat: latlng.lat, lng: latlng.lng)
		marker.captionText = "Test"

		marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
			print(overlay)
			return true
		}
		marker.mapView = mapView
	}
}
