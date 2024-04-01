//
//  SelectCheckView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/22/24.
//

import UIKit
import SnapKit

final class SelectCheckView: BaseUIView {
	let titleLabel = UILabel()

	private let stackView = UIStackView()
	let topButton = CheckButton()
	let midleButton = CheckButton()
	let lowButton = CheckButton()

	override func configureHierarchy() {
		[titleLabel, stackView].forEach { addSubview($0) }
	}

	override func configureLayout() {
		titleLabel.snp.makeConstraints {
			$0.top.equalTo(self).offset(betweenPadding)
			$0.horizontalEdges.equalTo(self)
		}

		stackView.snp.makeConstraints {
			$0.top.equalTo(titleLabel.snp.bottom).offset(betweenPadding)
			$0.horizontalEdges.equalTo(self)
			$0.bottom.equalTo(self)
		}
	}

	override func configureView() {
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.layoutMargins = UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: 10)
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.spacing = 10

		titleLabel.font = .boldSystemFont(ofSize: 20)
	}

	func setLayout(title: String, type: Int) {
		titleLabel.text = title

		if type == 0 {
			[topButton, midleButton, lowButton].forEach { stackView.addArrangedSubview($0) }
			topButton.setTitle("상", for: .normal)
			midleButton.setTitle("중", for: .normal)
			lowButton.setTitle("하", for: .normal)
		} else if type == 1 {
			[topButton, midleButton].forEach { stackView.addArrangedSubview($0) }
			topButton.setTitle("있음", for: .normal)
			midleButton.setTitle("없음", for: .normal)
		} else if type == 2 {
			[topButton, midleButton, lowButton].forEach { stackView.addArrangedSubview($0) }
			topButton.setTitle("단지 내", for: .normal)
			midleButton.setTitle("근처", for: .normal)
			lowButton.setTitle("멀리", for: .normal)
		}
	}

	func tapButton(_ buttonIndex: Int) {
		let buttons = [topButton, midleButton, lowButton]
		buttons.forEach {
			$0.tintColor = .white
		}

		buttons[buttonIndex].tintColor = .accent
	}
}
