//
//  RequestManager.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/8/24.
//

import Foundation
import Alamofire

final class RequestManager {
	enum APIError {
		case decodingError
	}

	func request<T: Decodable>(_ api: APIkind, _ type: T.Type, completionHandler: @escaping (T?, APIError?)->()) {
		AF.request(api.getURL).responseDecodable(of: T.self) { response in

			switch response.result {
			case .success(let success):
				completionHandler(success, nil)
				return
			case .failure(_):
				completionHandler(nil, .decodingError)
			}
		}
	}
}
