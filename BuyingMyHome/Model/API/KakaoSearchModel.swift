//
//  KakaoSearchModel.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/17/24.
//

import Foundation
import RealmSwift

struct KakaoSearchModel: Decodable {
	var documents: [KakaoSearchResult]
	var meta: KakaoSearchMeta
}

struct KakaoSearchResult: Decodable {
	let addressName: String
	private let categoryGroupCode: String
	let distance: String
	let id: String
	let placeName: String
	let placeURL: String
	let roadAddressName: String
	private let x: String
	private let y: String

	var categoryCode: PlaceType? {
		return PlaceType.allCases.filter { $0.rawValue == categoryGroupCode }.first
	}

	var lat: Double {
		return Double(y) ?? 0
	}

	var lng: Double {
		return Double(x) ?? 0
	}

	enum CodingKeys: String, CodingKey {
		case addressName = "address_name"
		case categoryGroupCode = "category_group_code"
		case distance
		case id
		case placeName = "place_name"
		case placeURL = "place_url"
		case roadAddressName = "road_address_name"
		case x
		case y
	}

	init(from data: SearchHistoryModel) {
		self.addressName = data.addressName
		self.distance = data.distance
		self.id = ""
		self.placeName = data.placeName
		self.placeURL = data.placeURL
		self.roadAddressName = data.roadAddressName
		self.categoryGroupCode = data.categoryCode
		self.x = "\(data.longitude)"
		self.y = "\(data.latitude)"
	}
}

struct KakaoSearchMeta: Decodable {
	var isEnd: Bool
	let totalCount: Int

	enum CodingKeys: String, CodingKey {
		case isEnd = "is_end"
		case totalCount = "total_count"
	}
}
