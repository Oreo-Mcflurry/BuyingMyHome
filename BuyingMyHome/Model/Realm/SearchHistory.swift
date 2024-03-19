//
//  SearchHistory.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/18/24.
//

import Foundation
import RealmSwift

class SearchHistoryModel: Object {
	@Persisted(primaryKey: true) var id: ObjectId
	@Persisted var addDate: Date = Date()
	@Persisted var symbol: String
	@Persisted var roadAddressName: String
	@Persisted var latitude: Double
	@Persisted var longitude: Double

	convenience init(from item: NaverGeocodingModel) {
		self.init()
		self.roadAddressName = item.address
		self.symbol = item.symbol
		self.latitude = item.lat
		self.longitude = item.lng
	}

	static let sortedProperty = "addDate"
}
