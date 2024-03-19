//
//  RealmDataManager.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/18/24.
//

import Foundation
import RealmSwift

class RealmDataManager {


	private var realm: Realm = {
		return try! Realm()
	}()

	func fetchData<T: Object>(_ type: T.Type) -> Results<T> {
		return realm.objects(T.self)
	}

	func saveData<T: Object>(_ data: T) {
		do {
			try realm.write {
				realm.add(data)
			}
		} catch {
			print(error)
		}
	}

	func deleteData<T: Object>(_ data: T) {
		do {
			try realm.write {
				realm.delete(data)
			}
		} catch {
			print(error)
		}
	}

//	func deleteDuplicate(_ data: KakaoSearchResult) {
////		fetchData(SearchHistoryModel.self).where { $0.roadAddressName == data.roadAddressName && $0.placeName == data.placeName }.forEach { value in
////			deleteData(value)
////		}
//	}
}

//enum RealmType {
//	case searchHistroy
//
//	var type: Object.Type {
//		return SearchHistoryModel.self
//	}
//}
