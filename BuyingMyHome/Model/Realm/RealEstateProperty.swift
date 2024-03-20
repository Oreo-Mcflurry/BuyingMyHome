//
//  RealEstateProperty.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/9/24.
//

import Foundation
import RealmSwift

final class RealEstateProperty: Object {
	@Persisted(primaryKey: true) var id: ObjectId
	@Persisted var addDate: Date
	@Persisted var folder: ObjectId?

	@Persisted var title: String
	@Persisted var goDate: Date
	@Persisted var x: Double
	@Persisted var y: Double
	@Persisted var usageType: Int
	@Persisted var placeType: Int
	@Persisted var buyType: Int
	@Persisted var checkLists: List<CheckList>
	@Persisted var aroundFacilities: List<AroundFacilitie>
	@Persisted var placeName: String?
	@Persisted var address: String?
	@Persisted var price: Int?
}
