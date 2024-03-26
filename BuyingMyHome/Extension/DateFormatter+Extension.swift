//
//  DateFormatter+Extension.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/18/24.
//

import Foundation

extension DateFormatter {
	static let formatDate: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM.dd"
		return formatter
	}()
}
