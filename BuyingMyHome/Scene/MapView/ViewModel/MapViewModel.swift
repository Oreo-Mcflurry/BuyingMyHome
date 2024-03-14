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
	let tapMapOutPut: Observable<(symbol: String, address: String)> = Observable(("", ""))
	private let tabMapMarker = NMFMarker()

	func tapMap(_ mapView: NMFMapView, latlng: NMGLatLng) {
		tapMapMakeMarker(mapView, latlng: latlng) { [weak self] address in
			self?.tapMapOutPut.value = ("", address)
		}
	}

	func tapSymbol(_ mapView: NMFMapView, didTap symbol: NMFSymbol) {
		tapMapMakeMarker(mapView, latlng: symbol.position) { [weak self] address in
			if Int(symbol.caption) != nil {
				self?.tapMapOutPut.value = ("", address)
			} else {
				self?.tapMapOutPut.value = (symbol.caption, address)
			}
		}
	}

	private func tapMapMakeMarker(_ mapView: NMFMapView, latlng: NMGLatLng, _ completionHandler: @escaping ((String)->Void)) {
		tabMapMarker.mapView = nil
		tabMapMarker.position = NMGLatLng(lat: latlng.lat, lng: latlng.lng)
		tabMapMarker.mapView = mapView


		let geocoder = CLGeocoder()
		geocoder.reverseGeocodeLocation(CLLocation(latitude: latlng.lat, longitude: latlng.lng)) { placemark, error in
			if error != nil { return }
			guard let place = placemark?.first else { return }
			completionHandler("\(place.locality ?? "") \(place.name ?? "")")
		}
	}
}
