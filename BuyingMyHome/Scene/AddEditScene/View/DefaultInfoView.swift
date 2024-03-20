//
//  DefaultInfoView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/20/24.
//

import UIKit
import SnapKit

final class DefaultInfoView: BaseUIView {
	private let infoLabel = InfoLabel()
	let addressTextField = AddEditHoshiTextField()
	let symbolTextField = AddEditHoshiTextField()
	let dongTextField = AddEditHoshiTextField()
	let hoTextField = AddEditHoshiTextField()

	override func configureHierarchy() {
		[infoLabel ,addressTextField, symbolTextField, dongTextField, hoTextField].forEach { self.addSubview($0) }
	}

	override func configureLayout() {

		infoLabel.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide)
			$0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(defaultPadding)
		}

		symbolTextField.snp.makeConstraints {
			$0.top.equalTo(infoLabel.snp.bottom)
			$0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(defaultPadding)
			$0.height.equalTo(textFieldSize)
		}

		addressTextField.snp.makeConstraints {
			$0.top.equalTo(symbolTextField.snp.bottom).offset(defaultPadding)
			$0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(defaultPadding)
			$0.height.equalTo(textFieldSize)
		}

		dongTextField.snp.makeConstraints {
			$0.top.equalTo(addressTextField.snp.bottom).offset(defaultPadding)
			$0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(defaultPadding)
			$0.height.equalTo(textFieldSize)
		}

		hoTextField.snp.makeConstraints {
			$0.top.equalTo(dongTextField.snp.bottom).offset(defaultPadding)
			$0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(defaultPadding)
			$0.height.equalTo(textFieldSize)
		}
	}

	override func configureView() {

		infoLabel.text = "기본 정보"

		symbolTextField.placeholder = "이름 (필수)"
		addressTextField.placeholder = "주소 (수정 불가)"
		dongTextField.placeholder = "동 (선택)"
		hoTextField.placeholder = "호수 (선택)"

		addressTextField.isEnabled = false
	}
}
