//
//  CustomHoshiTextField.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/20/24.
//

import UIKit
import TextFieldEffects

final class AddEditHoshiTextField: HoshiTextField {
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.borderActiveColor = .blue
		self.borderInactiveColor = .black
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
