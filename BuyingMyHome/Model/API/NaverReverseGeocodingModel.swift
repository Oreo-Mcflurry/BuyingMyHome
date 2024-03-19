//
//  NaverReverseGeocodingModel.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/19/24.
//

import Foundation

struct NaverReverseGeocodingModel: Decodable {
	private let results: [NaverGeocodingResult]

	var addreess: String {
		if let result = results.first {
			return "\(result.region.area1.name) \(result.region.area2.name) \(result.land.name) \(result.land.number1)"
		}
		return ""
	}
}

struct NaverGeocodingResult: Decodable {
	let region: Region
	let land: Land
}

struct Land: Decodable {
	let number1: String
	let name: String
}

struct Region: Decodable {
	let area1: Area
	let area2: Area
}

struct Area: Decodable {
	let name: String
}

