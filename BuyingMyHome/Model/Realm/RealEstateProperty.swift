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

	@Persisted var symbol: String
	@Persisted var address: String
	@Persisted var lat: Double
	@Persisted var lng: Double
	@Persisted var usageType: Int
	@Persisted var dong: String
	@Persisted var ho: String
	@Persisted var memo: String
	@Persisted var enviromentCheckLists: List<Int?>
	@Persisted var schoolCheckLists: List<Int?>
	@Persisted var insideCheckLists: List<Int?>

	convenience init(folder: ObjectId? = nil, symbol: String, address: String, lat: Double, lng: Double, usageType: Int, dong: String, ho: String, memo: String, enviromentCheckLists: List<Int?>, schoolCheckLists: List<Int?>, insideCheckLists: List<Int?>) {
		self.init()
		self.addDate = Date()
		self.folder = folder
		self.symbol = symbol
		self.address = address
		self.lat = lat
		self.lng = lng
		self.usageType = usageType
		self.dong = dong
		self.ho = ho
		self.memo = memo
		self.enviromentCheckLists = enviromentCheckLists
		self.schoolCheckLists = schoolCheckLists
		self.insideCheckLists = insideCheckLists
	}

	var enviromentCheckArray: [Int?] {
		var array = [Int?]()
		enviromentCheckLists.forEach { array.append($0) }
		return array
	}

	var schoolCheckArray: [Int?] {
		var array = [Int?]()
		schoolCheckLists.forEach { array.append($0) }
		return array
	}

	var insideCheckArray: [Int?] {
		var array = [Int?]()
		insideCheckLists.forEach { array.append($0) }
		return array
	}

}
