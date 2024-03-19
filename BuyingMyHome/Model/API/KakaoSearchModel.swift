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
	private let categoryGroupCode: String
	let placeName: String
	let roadAddressName: String

	var categoryCode: PlaceType? {
		return PlaceType.allCases.filter { $0.rawValue == categoryGroupCode }.first
	}

	enum CodingKeys: String, CodingKey {
		case categoryGroupCode = "category_group_code"
		case roadAddressName = "road_address_name"
		case placeName = "place_name"
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
