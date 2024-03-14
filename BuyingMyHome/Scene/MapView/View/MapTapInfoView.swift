//
//  InfoView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/12/24.
//

import UIKit
import SnapKit

final class MapTapInfoView: BaseUIView {
	let symbolLabel = UILabel()
	let addressLabel = UILabel()
	let addButton = UIButton(configuration: .filled())

	override func configureHierarchy() {
		[symbolLabel, addressLabel, addButton].forEach { addSubview($0) }
	}

	override func configureLayout() {
		addressLabel.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(self).inset(defautPadding)
		}

		symbolLabel.snp.makeConstraints {
			$0.top.equalTo(addressLabel.snp.bottom).offset(betweenPadding)
			$0.horizontalEdges.equalTo(self).inset(defautPadding)
		}
		
		addButton.snp.makeConstraints {
			$0.top.equalTo(symbolLabel.snp.bottom).offset(betweenPadding)
			$0.trailing.equalTo(self).inset(defautPadding)
			$0.leading.greaterThanOrEqualTo(self).inset(defautPadding)
			$0.bottom.equalTo(self).inset(defautPadding)
		}
	}

	override func configureView() {
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOpacity = 0.2
		self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)

		self.backgroundColor = .white
		self.layer.cornerRadius = 10

		addButton.setTitle("추가하기", for: .normal)
		addButton.setTitleColor(.black, for: .normal)
		addButton.tintColor = .lightGray
		addButton.clipsToBounds = true
		addButton.layer.cornerRadius = 10

		symbolLabel.textColor = .darkGray
		addressLabel.textColor = .black
		addressLabel.font = .boldSystemFont(ofSize: 25)
		addressLabel.numberOfLines = 0
	}
}
