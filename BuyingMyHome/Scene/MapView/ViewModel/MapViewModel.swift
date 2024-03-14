//
//  MapViewModel.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/13/24.
//

import Foundation
import NMapsMap
import MapKit

final class MapViewModel {
	private let tabMapMarker = NMFMarker()


	func tapMapMakeMarker(_ mapView: NMFMapView, latlng: NMGLatLng) {
		tabMapMarker.mapView = nil
		tabMapMarker.position = NMGLatLng(lat: latlng.lat, lng: latlng.lng)
		tabMapMarker.mapView = mapView
		convertLatLngToAddress(latlng: latlng)
	}

	func tapSymbol(_ mapView: NMFMapView, didTap symbol: NMFSymbol) {
		print(symbol.caption)
		tapMapMakeMarker(mapView, latlng: symbol.position)
		convertLatLngToAddress(latlng: symbol.position)
	}

	private func convertLatLngToAddress(latlng: NMGLatLng) {
		let geocoder = CLGeocoder()

		geocoder.reverseGeocodeLocation(CLLocation(latitude: latlng.lat, longitude: latlng.lng)) { placemark, error in
			if error != nil { return }
			guard let place = placemark?.first else { return }
			print("\(place.country ?? "") \(place.locality ?? "") \(place.name ?? "")")
		}
	}
}
