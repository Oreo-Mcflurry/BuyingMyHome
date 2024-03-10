//
//  APIManger.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/8/24.
//

import Foundation

enum APIkind {
	case test

	var type: Decodable.Type {
		switch self {
		case .test:
		 return Test.self
		}
	}

	var getURL: URL {
		switch self {
		case .test:
			return URL(string: "")!
		}
	}
}

struct Test: Decodable {
	let name: String
}
