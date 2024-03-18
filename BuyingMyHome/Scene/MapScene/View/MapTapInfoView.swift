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
	let cancelButton = UIButton()

	override func configureHierarchy() {
		[symbolLabel, cancelButton, addressLabel, addButton].forEach { addSubview($0) }
	}

	override func configureLayout() {
		addressLabel.snp.makeConstraints {
			$0.top.leading.equalTo(self).inset(defautPadding)
		}

		cancelButton.snp.makeConstraints {
			$0.top.trailing.equalTo(self).inset(defautPadding)
			$0.leading.equalTo(addressLabel.snp.trailing).offset(defautPadding)
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
		addButton.setTitleColor(.white, for: .normal)
		addButton.tintColor = .accent
		addButton.clipsToBounds = true
		addButton.layer.cornerRadius = 10

		cancelButton.setImage(UIImage(systemName: "xmark")?.withTintColor(.accent), for: .normal)

		symbolLabel.textColor = .darkGray
		addressLabel.textColor = .black
		addressLabel.font = .boldSystemFont(ofSize: 25)
		addressLabel.numberOfLines = 0
	}
}
