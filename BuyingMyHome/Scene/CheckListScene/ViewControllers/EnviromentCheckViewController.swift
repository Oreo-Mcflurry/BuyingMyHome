//
//  EnviromentCheckViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/23/24.
//

import UIKit
import SnapKit

final class EnviromentCheckViewController: BaseViewController {

	let wasteCheck = SelectCheckView()
	let parkingCheck = SelectCheckView()
	let communityCheck = SelectCheckView()
	let flatCheck = SelectCheckView()

	let highJobsCheck = SelectCheckView()
	let commercialCheck = SelectCheckView()
	let residentialCheck = SelectCheckView()
	let forignCarCheck = SelectCheckView()
	var enviromentCheck: [Int?] = [nil, nil, nil, nil, nil, nil, nil, nil] {
		didSet {
			[wasteCheck, parkingCheck, communityCheck, flatCheck, highJobsCheck, commercialCheck, residentialCheck, forignCarCheck].enumerated().forEach { (index, item) in
				[item.topButton, item.midleButton, item.lowButton].enumerated().forEach { (buttonIndex, button) in
					if let value = enviromentCheck[index], value == buttonIndex {
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
		[wasteCheck, parkingCheck, communityCheck, flatCheck, highJobsCheck, commercialCheck, residentialCheck, forignCarCheck].forEach { view.addSubview($0) }
	}

	override func configureLayout() {
		wasteCheck.snp.makeConstraints {
			 $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		parkingCheck.snp.makeConstraints {
			 $0.top.equalTo(wasteCheck.snp.bottom)
			 $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		communityCheck.snp.makeConstraints {
			 $0.top.equalTo(parkingCheck.snp.bottom)
			 $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		flatCheck.snp.makeConstraints {
			 $0.top.equalTo(communityCheck.snp.bottom)
			 $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		highJobsCheck.snp.makeConstraints {
			 $0.top.equalTo(flatCheck.snp.bottom)
			 $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		commercialCheck.snp.makeConstraints {
			 $0.top.equalTo(highJobsCheck.snp.bottom)
			 $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		residentialCheck.snp.makeConstraints {
			 $0.top.equalTo(commercialCheck.snp.bottom)
			 $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

		forignCarCheck.snp.makeConstraints {
			$0.top.equalTo(residentialCheck.snp.bottom)
			$0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
			$0.bottom.lessThanOrEqualTo(view)
		}
	}

	override func configureView() {
		wasteCheck.setLayout(title: "단지내 쓰레기 처리 시설 여부", type: 0)
		parkingCheck.setLayout(title: "단지 내 주차장 혼잡도", type: 0)
		communityCheck.setLayout(title: "단지 내 커뮤니티 시설 여부", type: 0)
		flatCheck.setLayout(title: "단지 내 평지 여부", type: 0)
		highJobsCheck.setLayout(title: "근처 고급 일자리 여부", type: 1)
		commercialCheck.setLayout(title: "근처 상권 형성 여부", type: 1)
		residentialCheck.setLayout(title: "근처 대단지 입주 여부", type: 0)
		forignCarCheck.setLayout(title: "외제차 빈도", type: 1)

		[wasteCheck, parkingCheck, communityCheck, flatCheck, highJobsCheck, commercialCheck, residentialCheck, forignCarCheck].enumerated().forEach { (index, item) in
			[item.topButton, item.midleButton, item.lowButton].enumerated().forEach { (buttonIndex, button) in
				button.tag = (index * 10) + buttonIndex
				button.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
			}
		}
	}

	@objc private func tapButton(sender: UIButton) {
		let index = sender.tag / 10
		let buttonIndex = sender.tag % 10
		enviromentCheck[index] = buttonIndex
	}
}
