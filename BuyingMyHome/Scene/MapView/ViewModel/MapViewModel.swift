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

	let searchResultInput: Observable<KakaoSearchResult?> = Observable(nil)
	let searchResultOutput: Observable<KakaoSearchResult?> = Observable(nil)

	private let tabMapMarker = NMFMarker()

	init() {
		cancelButtonInput.bind { [weak self] _ in
			self?.deleteMarker()
			self?.cancelButtonOutput.value = ()
		}

		searchButtonInput.bind { [weak self] _ in
			self?.searchButtonOutput.value = ()
		}

		searchResultInput.bind { [weak self] value in
			self?.searchResultOutput.value = value
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

	func searchMarker(_ mapView: NMFMapView, latlng: NMGLatLng) {
		deleteMarker()
		makeMarker(mapView, latlng: latlng)
	}

	private func tapMapMakeMarker(_ mapView: NMFMapView, latlng: NMGLatLng, _ completionHandler: @escaping ((String)->Void)) {
		deleteMarker()
		makeMarker(mapView, latlng: latlng)


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

	private func makeMarker(_ mapView: NMFMapView, latlng: NMGLatLng) {
		DispatchQueue.main.async { [weak self] in
			self?.tabMapMarker.position = NMGLatLng(lat: latlng.lat, lng: latlng.lng)
			self?.tabMapMarker.mapView = mapView
		}
	}
}
