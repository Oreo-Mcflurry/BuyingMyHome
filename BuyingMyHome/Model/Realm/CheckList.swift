//
//  CheckList.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/9/24.
//

import Foundation
import RealmSwift

class CheckList: Object {
	@Persisted(primaryKey: true) var id: ObjectId

	@Persisted var checkTitle: String
	@Persisted var checkType: Int
	@Persisted var state: Int?
	@Persisted var memo: String?
}
