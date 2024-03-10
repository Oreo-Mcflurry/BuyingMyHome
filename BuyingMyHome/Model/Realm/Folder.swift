//
//  Folder.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/9/24.
//

import Foundation
import RealmSwift

class Folder: Object {
	@Persisted(primaryKey: true) var id: ObjectId
	@Persisted var title: String
}

