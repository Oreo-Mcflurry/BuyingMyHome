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
//	let imageSelectView = ImageSelectView()

	override func configureHierarchy() {
		[infoLabel, memoTextField].forEach { addSubview($0) }
	}

	override func configureLayout() {
		infoLabel.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide)
			$0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(defaultPadding)
		}

		memoTextField.snp.makeConstraints {
			$0.top.equalTo(infoLabel.snp.bottom).offset(betweenPadding)
			$0.horizontalEdges.equalTo(self.safeAreaInsets).inset(defaultPadding)
			$0.height.equalTo(textFieldSize)
		}

//		imageSelectView.snp.makeConstraints {
//			$0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(defaultPadding)
//			$0.top.equalTo(memoTextField.snp.bottom).offset(betweenPadding)
//		}

	}

	override func configureView() {
		infoLabel.text = "한줄 평가"
		memoTextField.placeholder = "한줄 메모 (선택)"
	}
}
