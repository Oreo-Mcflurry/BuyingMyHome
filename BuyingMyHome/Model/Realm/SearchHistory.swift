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
	@Persisted var addressName: String = ""
	@Persisted var categoryCode: String = "" // Store categoryGroupCode as String
	@Persisted var distance: String = ""
	@Persisted var placeName: String = ""
	@Persisted var placeURL: String = ""
	@Persisted var roadAddressName: String = ""
	@Persisted var latitude: Double = 0.0 // Latitude
	@Persisted var longitude: Double = 0.0 // Longitude

	convenience init(from result: KakaoSearchResult) {
		self.init()
		self.addressName = result.addressName
		self.categoryCode = "" // Store categoryGroupCode as String
		self.distance = result.distance
		self.placeName = result.placeName
		self.placeURL = result.placeURL
		self.roadAddressName = result.roadAddressName
		self.latitude = result.lat
		self.longitude = result.lng
	}

	static let sortedProperty = "addDate"
}
