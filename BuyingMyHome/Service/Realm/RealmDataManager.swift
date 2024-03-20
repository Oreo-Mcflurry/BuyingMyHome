//
//  RealmDataManager.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/18/24.
//

import Foundation
import RealmSwift

final class RealmDataManager {
	
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

	func deleteDuplicate(_ data: SearchToMapDataPassingModel) {
		if let data = fetchData(SearchHistoryModel.self).where({ $0.roadAddressName == data.address && $0.latitude == data.lat && $0.longitude == data.lng }).first {
			deleteData(data)
		}
	}
}

//enum RealmType {
//	case searchHistroy
//
//	var type: Object.Type {
//		return SearchHistoryModel.self
//	}
//}
