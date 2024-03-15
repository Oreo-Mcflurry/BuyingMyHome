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

	let cancelButtonInput: Observable<Void?> = Observable(nil)
	let cancelButtonOutput: Observable<Void?> = Observable(nil)

	let searchButtonInput: Observable<Void?> = Observable(nil)
	let searchButtonOutput: Observable<Void?> = Observable(nil)

	private let tabMapMarker = NMFMarker()

	init() {
		cancelButtonInput.bind { [weak self] _ in
			self?.deleteMarker()
			self?.cancelButtonOutput.value = ()
		}

		searchButtonInput.bind { [weak self] _ in
			self?.searchButtonOutput.value = ()
		}
	}

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
		deleteMarker()
		tabMapMarker.position = NMGLatLng(lat: latlng.lat, lng: latlng.lng)
		tabMapMarker.mapView = mapView


		let geocoder = CLGeocoder()
		geocoder.reverseGeocodeLocation(CLLocation(latitude: latlng.lat, longitude: latlng.lng)) { placemark, error in
			if error != nil { return }
			guard let place = placemark?.first else { return }
			completionHandler("\(place.locality ?? "") \(place.name ?? "")")
		}
	}

	private func deleteMarker() {
		tabMapMarker.mapView = nil
	}
}
