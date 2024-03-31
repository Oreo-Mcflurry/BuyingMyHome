//
//  OnboardingView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/28/24.
//

import UIKit
import SnapKit

final class OnboardingView: BaseUIView {

	let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
	let skipButton = UIButton()

	override func configureHierarchy() {
		[pageViewController.view, skipButton].forEach { addSubview($0) }
	}

	override func configureLayout() {
		skipButton.snp.makeConstraints {
			$0.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
			$0.height.equalTo(45)
		}

		pageViewController.view.snp.makeConstraints {
			$0.bottom.equalTo(skipButton.snp.top).offset(-20)
			$0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
		}
	}

	override func configureView() {
		skipButton.backgroundColor = .accent
		skipButton.layer.cornerRadius = 10

		UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.accent
		UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray
	}

	func configureTitle(_ value: Int) {
		skipButton.setTitle( value == 2 ? "시작하기!" : "다음", for: .normal)
	}
}

