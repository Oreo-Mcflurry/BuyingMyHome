//
//  ImageMemoView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/20/24.
//

import UIKit
import SnapKit

final class ImageMemoView: BaseUIView {
	private let infoLabel = InfoLabel()
	let memoTextField = AddEditHoshiTextField()
	let imageAddButton = UIButton()

	override func configureHierarchy() {
		[infoLabel, memoTextField, imageAddButton].forEach { addSubview($0) }
	}

	override func configureLayout() {
		infoLabel.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide)
			$0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(defaultPadding)
		}

		memoTextField.snp.makeConstraints {
			$0.top.equalTo(infoLabel.snp.bottom)
			$0.horizontalEdges.equalTo(self.safeAreaInsets).inset(defaultPadding)
		}
	}

	override func configureView() {
		infoLabel.text = "한줄 평가"
	}
}
