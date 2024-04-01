//
//  DetailCheckListViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/22/24.
//

import UIKit
import SnapKit

final class InsideCheckViewController: BaseViewController {

	let illuminationCheck = SelectCheckView()
	let soundproofingCheck = SelectCheckView()
	let waterLeakCheck = SelectCheckView()
	let heatingCheck = SelectCheckView()
	let sunlightCheck = SelectCheckView()
	let moldCheck = SelectCheckView()
	let floorCheck = SelectCheckView()
	var insideCheck: [Int?] = [nil, nil, nil, nil, nil, nil, nil, nil] {
		didSet {
			[illuminationCheck, soundproofingCheck, waterLeakCheck, heatingCheck, sunlightCheck, moldCheck, floorCheck].enumerated().forEach { (index, item) in
				[item.topButton, item.midleButton, item.lowButton].enumerated().forEach { (buttonIndex, button) in
					if let value = insideCheck[index], value == buttonIndex {
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
		[illuminationCheck, soundproofingCheck, waterLeakCheck, heatingCheck, sunlightCheck, moldCheck, floorCheck].forEach { view.addSubview($0) }
	}

	override func configureLayout() {
		illuminationCheck.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		soundproofingCheck.snp.makeConstraints {
			$0.top.equalTo(illuminationCheck.snp.bottom)
			$0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		waterLeakCheck.snp.makeConstraints {
			$0.top.equalTo(soundproofingCheck.snp.bottom)
			$0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		heatingCheck.snp.makeConstraints {
			$0.top.equalTo(waterLeakCheck.snp.bottom)
			$0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		sunlightCheck.snp.makeConstraints {
			$0.top.equalTo(heatingCheck.snp.bottom)
			$0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		moldCheck.snp.makeConstraints {
			$0.top.equalTo(sunlightCheck.snp.bottom)
			$0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		floorCheck.snp.makeConstraints {
			$0.top.equalTo(moldCheck.snp.bottom)
			$0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
			$0.bottom.lessThanOrEqualTo(view)
		}
	}

	override func configureView() {
		[illuminationCheck, soundproofingCheck, waterLeakCheck, heatingCheck, sunlightCheck, moldCheck, floorCheck].enumerated().forEach { (index, item) in
			[item.topButton, item.midleButton, item.lowButton].enumerated().forEach { (buttonIndex, button) in
				button.tag = (index * 10) + buttonIndex
				button.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
			}
		}

		illuminationCheck.setLayout(title: "채광량", type: 1)
		soundproofingCheck.setLayout(title: "방음", type: 1)
		waterLeakCheck.setLayout(title: "누수", type: 1)
		heatingCheck.setLayout(title: "난방", type: 1)
		sunlightCheck.setLayout(title: "일조권", type: 1)
		moldCheck.setLayout(title: "곰팡이", type: 1)
		floorCheck.setLayout(title: "타일 상태", type: 1)
	}

	@objc private func tapButton(sender: UIButton) {

		let index = sender.tag / 10
		let buttonIndex = sender.tag % 10
		insideCheck[index] = buttonIndex
	}
}
