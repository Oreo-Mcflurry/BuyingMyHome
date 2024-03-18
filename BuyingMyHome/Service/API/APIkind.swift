//
//  APIManger.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/8/24.
//

import Foundation
import Alamofire

enum APIkind {
	case kakaoSearch(searchText: String, page: Int, placeType: [PlaceType]? = nil)

	var getURL: URL {
		switch self {
		case .kakaoSearch:
			return URL(string: "https://dapi.kakao.com/v2/local/search/keyword.json")!
		}
	}

	var method: HTTPMethod {
		return .get
	}

	var header: HTTPHeaders {
		switch self {
		case .kakaoSearch:
			return ["Authorization": APIkeys.kakaoSecreat.rawValue]
		}
	}

	var parameter: Parameters {
		switch self {
		case .kakaoSearch(let searchText, let page, let placeType):
			if let placeType {
				let placeString = placeType.map { $0.rawValue }.joined(separator: ",")
				return ["query": searchText, "category_group_code": placeString, "page": "\(page)"]
			} else {
				return ["query": searchText, "page": "\(page)"]
			}
		}
	}
}
