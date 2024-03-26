//
//  MapViewModel.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/13/24.
//

import Foundation
import NMapsMap
import MapKit
import RealmSwift

final class MapViewModel {

	private var savedDatas: Results<RealEstateProperty>!
	private var token : NotificationToken?

	let tapMapOutPut: Observable<(symbol: String, address: String, type: AddEditType)> = Observable(("", "", .add))

	let cancelButtonInput: Observable<Void?> = Observable(nil)
	let cancelButtonOutput: Observable<Void?> = Observable(nil)

	let searchButtonInput: Observable<Void?> = Observable(nil)
	let searchButtonOutput: Observable<Void?> = Observable(nil)

	let addEditbuttonInput: Observable<Void?> = Observable(nil)
	let addEditbuttonOutput: Observable<Void?> = Observable(nil)

	let searchResultInput: Observable<SearchToMapDataPassingModel?> = Observable(nil)
	let searchResultOutput: Observable<SearchToMapDataPassingModel?> = Observable(nil)

	var searchResult: SearchToMapDataPassingModel?
	var markerValue: RealEstateProperty?

	private let tabMapMarker = NMFMarker()
	private var savedMapMarkers: [NMFMarker] = []
	var mapView: NMFMapView?

	init() {
		savedDatas = RealmDataManager().fetchData(RealEstateProperty.self)

		token = savedDatas.observe { [weak self] change in
			switch change {
			case .initial, .update: self?.makeSavedMarker()
			case .error: break
			}
		}

		cancelButtonInput.bind { [weak self] _ in
			self?.searchResult = nil
			self?.markerValue = nil
			self?.deleteTapMarker()
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
			self?.deleteTapMarker()
			self?.addEditbuttonOutput.value = ()
		}
	}

	func tapSymbol(_ mapView: NMFMapView, didTap symbol: NMFSymbol) {
		if Int(symbol.caption) != nil || symbol.caption.count == 1 { return }
		tapMapMakeMarker(mapView, latlng: symbol.position) { [weak self] address in
			if address.isEmpty { return }
			self?.deleteTapMarker()
			self?.makeMarker(mapView, latlng: symbol.position)

			if let data = RealmDataManager().findDuplicate(symbol.position.lat, symbol.position.lng) {
				self?.tapMapOutPut.value = (data.symbol, data.address, .edit)
				self?.markerValue = data
			} else {
				self?.tapMapOutPut.value = (symbol.caption, address, .add)
			}

			self?.searchResult = SearchToMapDataPassingModel(lat: symbol.position.lat, lng: symbol.position.lng, address: address, symbol: symbol.caption)
		}
	}

	private func tapMarker(_ marker: NMFMarker) {
		guard let data = marker.userInfo["data"] as? RealEstateProperty else { return }
		guard let mapView else { return }
		searchResult = nil
		self.markerValue = data
		self.deleteTapMarker()
		self.tapMapOutPut.value = (data.symbol, data.address, .edit)
		self.makeMarker(mapView, latlng: NMGLatLng(lat: data.lat, lng: data.lng))
	}

	func searchMarker(_ mapView: NMFMapView, latlng: NMGLatLng) {
		deleteTapMarker()
		makeMarker(mapView, latlng: latlng)
		mapView.moveCamera(NMFCameraUpdate(scrollTo: latlng))
		mapView.zoomLevel = 15
	}

	private func makeSavedMarker() {
		savedMapMarkers.forEach { $0.mapView = nil }

		savedDatas.forEach {
			let marker = NMFMarker()
			marker.position = NMGLatLng(lat: $0.lat, lng: $0.lng)
			marker.iconTintColor = UIColor.red
			marker.mapView = mapView
			marker.captionText = $0.symbol
			marker.userInfo = ["data": $0]
			marker.touchHandler = { [weak self] _ in
				self?.tapMarker(marker)
				return true
			}
			savedMapMarkers.append(marker)
		}
	}

	private func tapMapMakeMarker(_ mapView: NMFMapView, latlng: NMGLatLng, _ completionHandler: @escaping ((String)->Void)) {
		requestGecoding(latlng, completionHandler)
	}

	private func deleteTapMarker() {
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
