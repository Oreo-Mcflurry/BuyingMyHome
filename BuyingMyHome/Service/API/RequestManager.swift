//
//  RequestManager.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/8/24.
//

import Foundation
import Alamofire

final class RequestManager {

	enum APIError: Error {
		case error
	}

	func request<T: Decodable>(_ api: APIkind, _ type: T.Type, completionHandler: @escaping (T?, APIError?)->()) {
		AF.request(api.url, parameters: api.parameter, headers: api.header) { request in
			request.cachePolicy = .returnCacheDataElseLoad
		}.responseDecodable(of: T.self) { response in
//			debugPrint(response)
			switch response.result {
			case .success(let success):
				completionHandler(success, nil)
				return
			case .failure(_):
				completionHandler(nil, .error)
			}
		}
	}
}
