//
//  UISearchHistoryTableViewCell.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/16/24.
//

import UIKit
import SnapKit

final class SearchHistoryTableViewCell: BaseTableViewCell {
	let addressLabel = UILabel()
	let deleteButton = UIButton()
	let dateLabel = UILabel()

	override func configureHierarchy() {
		[addressLabel, deleteButton, dateLabel].forEach { contentView.addSubview($0) }
	}

	override func configureLayout() {
		addressLabel.snp.makeConstraints {
			$0.leading.equalTo(self.contentView).offset(defautPadding)
			$0.verticalEdges.equalTo(self.contentView).inset(betweenPadding)
		}

		dateLabel.snp.makeConstraints {
			$0.leading.greaterThanOrEqualTo(addressLabel).offset(betweenPadding)
			$0.verticalEdges.equalTo(addressLabel)
		}

		deleteButton.snp.makeConstraints {
			$0.leading.equalTo(dateLabel.snp.trailing).offset(betweenPadding)
			$0.verticalEdges.equalTo(addressLabel)
			$0.trailing.equalTo(self.contentView).inset(defautPadding)
		}
	}

	override func configureView() {

		dateLabel.font = .systemFont(ofSize: 14)
		dateLabel.textColor = .gray

		deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
	}

	func configurationCell(_ data: SearchHistoryModel) {
		addressLabel.text = data.symbol.isEmpty ? data.roadAddressName : data.symbol
		dateLabel.text = DateFormatter.searchDateFormatter.string(from: data.addDate)
	}
}
