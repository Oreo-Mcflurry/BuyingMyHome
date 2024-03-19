//
//  NaverGeocodingModel.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/19/24.
//

import Foundation

struct NaverGeocodingModel: Decodable {
	private let addresses: [Address]

	var lat: Double {
		return Double(addresses.first?.y ?? "0") ?? 0
	}

	var lng: Double {
		return Double(addresses.first?.x ?? "0") ?? 0
	}

	var address: String {
		guard let address = addresses.first else { return "" }

		var addressString = ""
		let typesArray = ["SIDO", "SIGUGUN", "ROAD_NAME", "BUILDING_NUMBER"]
		address.addressElements.forEach { item in
			if let itemFirst = item.types.first, typesArray.contains(itemFirst) {
				addressString += "\(item.longName) "
			}
		}
		return addressString
	}

	var symbol: String {
		return addresses.first?.addressElements.first(where: { $0.types.contains("BUILDING_NAME") })?.longName ?? ""
	}
}

struct Address: Decodable {
	let addressElements: [AddressElement]
	let x: String
	let y: String
}

struct AddressElement: Decodable {
	let types: [String]
	let longName: String
}

