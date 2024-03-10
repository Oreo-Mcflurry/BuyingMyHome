//
//  AroundFacilitie.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/9/24.
//

import Foundation
import RealmSwift

class AroundFacilitie: Object {
	@Persisted(primaryKey: true) var id: ObjectId
	@Persisted var facilitieName: String
	@Persisted var x: Double
	@Persisted var y: Double
	@Persisted var address: String
	@Persisted var url: String?
	@Persisted var distance: Double
	@Persisted var cateogry: Int
}
