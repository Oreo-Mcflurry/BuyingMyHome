//
//  InfoLabel.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/20/24.
//

import UIKit

final class InfoLabel: UILabel {

	override init(frame: CGRect) {
		super.init(frame: frame)
		font = .boldSystemFont(ofSize: 20)
	}

	required init?(coder: NSCoder) {
		fatalError()
	}
}
