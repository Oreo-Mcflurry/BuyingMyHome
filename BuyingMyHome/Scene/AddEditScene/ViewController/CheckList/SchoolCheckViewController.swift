//
//  SchoolCheckViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/23/24.
//

import UIKit
import SnapKit

final class SchoolCheckViewController: BaseViewController {

	let preschool = SelectCheckView()
	let elementSchool = SelectCheckView()
	let middleSchool = SelectCheckView()
	let highSchool = SelectCheckView()
	var schoolCheck: [Int?] = [nil, nil, nil, nil] {
		didSet {
			[preschool, elementSchool, middleSchool, highSchool].enumerated().forEach { (index, item) in
				[item.topButton, item.midleButton, item.lowButton].enumerated().forEach { (buttonIndex, button) in
					if let value = schoolCheck[index], value == buttonIndex {
						item.tapButton(buttonIndex)
					}
				}
			}

		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureHierarchy() {
		[preschool, elementSchool, middleSchool, highSchool].forEach { view.addSubview($0) }
	}

	override func configureLayout() {
		preschool.snp.makeConstraints {
			 $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		elementSchool.snp.makeConstraints {
			 $0.top.equalTo(preschool.snp.bottom)
			 $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		middleSchool.snp.makeConstraints {
			 $0.top.equalTo(elementSchool.snp.bottom)
			 $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		highSchool.snp.makeConstraints {
			 $0.top.equalTo(middleSchool.snp.bottom)
			 $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
			 $0.bottom.lessThanOrEqualTo(view)
		}
	}

	override func configureView() {
		[preschool, elementSchool, middleSchool, highSchool].enumerated().forEach { (index, item) in
			[item.topButton, item.midleButton, item.lowButton].enumerated().forEach { (buttonIndex, button) in
				button.tag = (index * 10) + buttonIndex
				button.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
			}
		}

		preschool.setLayout(title: "단지 내 어린이집 여부", type: 2)
		elementSchool.setLayout(title: "초품아 여부", type: 2)
		middleSchool.setLayout(title: "근처 중학교 수준", type: 0)
		highSchool.setLayout(title: "근처 고등학교 수준", type: 0)
	}

	@objc private func tapButton(sender: UIButton) {
		let index = sender.tag / 10
		let buttonIndex = sender.tag % 10
		schoolCheck[index] = buttonIndex
	}
}
