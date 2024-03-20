//
//  SearchToMapDataPassingModel.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/19/24.
//

import Foundation

final class SearchToMapDataPassingModel {
	let lat: Double
	let lng: Double
	let address: String
	let symbol: String

	init(from data: NaverGeocodingModel) {
		self.lat = data.lat
		self.lng = data.lng
		self.address = data.address
		self.symbol = data.symbol
	}

	init(from data: SearchHistoryModel) {
		self.lat = data.latitude
		self.lng = data.longitude
		self.address = data.roadAddressName
		self.symbol = data.symbol
	}
}
