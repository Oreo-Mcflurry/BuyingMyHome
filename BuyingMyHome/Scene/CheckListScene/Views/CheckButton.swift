//
//  CheckButton.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/22/24.
//

import UIKit

class CheckButton: UIButton {

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.configuration = .filled()
		self.tintColor = .white

		self.layer.cornerRadius = 10
		self.layer.borderColor = UIColor.accent.cgColor
		self.layer.borderWidth = 1
	}

	required init?(coder: NSCoder) {
		fatalError()
	}
}
