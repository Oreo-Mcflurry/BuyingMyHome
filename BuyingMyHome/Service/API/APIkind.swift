//
//  APIManger.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/8/24.
//

import Foundation
import Alamofire
import NMapsMap

enum APIkind {
	case kakaoSearch(searchText: String, page: Int, placeType: [PlaceType]? = nil)
	case naverReverseGeocoding(latlng: NMGLatLng)
	case naverGeocoding(address: String)

	var getType: Decodable.Type {
		switch self {
		case .kakaoSearch:
			return KakaoSearchModel.self
		case .naverReverseGeocoding:
			return KakaoSearchModel.self
		case .naverGeocoding:
			return NaverGeocodingModel.self
		}
	}

	var url: URL {
		switch self {
		case .kakaoSearch:
			return URL(string: "https://dapi.kakao.com/v2/local/search/keyword.json")!
		case .naverReverseGeocoding:
			return URL(string: "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc")!
		case .naverGeocoding:
			return URL(string: "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode")!
		}
	}

	var method: HTTPMethod {
		return .get
	}

	var header: HTTPHeaders {
		switch self {
		case .kakaoSearch:
			return ["Authorization": APIkeys.kakaoSecreat.rawValue]
		case .naverReverseGeocoding, .naverGeocoding:
			return ["X-NCP-APIGW-API-KEY-ID": APIkeys.naverMapClient.rawValue, "X-NCP-APIGW-API-KEY": APIkeys.naverMapSecreat.rawValue]
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
		case .naverReverseGeocoding(latlng: let latlng):
			let coordsString = "\(latlng.lng),\(latlng.lat)"
			return ["coords": coordsString, "output": "json", "orders": "roadaddr"]
		case .naverGeocoding(address: let address):
			return ["query": address]
		}
	}
}
