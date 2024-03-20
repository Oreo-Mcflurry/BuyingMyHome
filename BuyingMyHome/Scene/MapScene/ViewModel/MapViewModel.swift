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

	let addEditbuttonInput: Observable<Void?> = Observable(nil)
	let addEditbuttonOutput: Observable<Void?> = Observable(nil)

	let searchResultInput: Observable<SearchToMapDataPassingModel?> = Observable(nil)
	let searchResultOutput: Observable<SearchToMapDataPassingModel?> = Observable(nil)

	var searchResult: SearchToMapDataPassingModel?

	private let tabMapMarker = NMFMarker()

	init() {
		cancelButtonInput.bind { [weak self] _ in
			self?.searchResult = nil
			self?.deleteMarker()
			self?.cancelButtonOutput.value = ()
		}

		searchButtonInput.bind { [weak self] _ in
			self?.searchButtonOutput.value = ()
		}

		searchResultInput.bind { [weak self] value in
			self?.searchResult = value
			self?.searchResultOutput.value = value
		}

		addEditbuttonInput.bind { [weak self] _ in
			self?.addEditbuttonOutput.value = ()
		}
	}

	func tapSymbol(_ mapView: NMFMapView, didTap symbol: NMFSymbol) {
		if Int(symbol.caption) != nil || symbol.caption.count == 1 { return }
		tapMapMakeMarker(mapView, latlng: symbol.position) { [weak self] address in
			if address.isEmpty { return }
			self?.deleteMarker()
			self?.makeMarker(mapView, latlng: symbol.position)
			self?.tapMapOutPut.value = (symbol.caption, address)
		}

	}

	func searchMarker(_ mapView: NMFMapView, latlng: NMGLatLng) {
		deleteMarker()
		makeMarker(mapView, latlng: latlng)
		mapView.moveCamera(NMFCameraUpdate(scrollTo: latlng))
		mapView.zoomLevel = 15
	}

	private func tapMapMakeMarker(_ mapView: NMFMapView, latlng: NMGLatLng, _ completionHandler: @escaping ((String)->Void)) {
		requestGecoding(latlng, completionHandler)
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

	private func requestGecoding(_ latlng: NMGLatLng, _ completionHandler: @escaping ((String)->Void)) {
		RequestManager().request(.naverReverseGeocoding(latlng: latlng), NaverReverseGeocodingModel.self) { result, error in
			completionHandler(result?.addreess ?? "")
		}
	}
}
