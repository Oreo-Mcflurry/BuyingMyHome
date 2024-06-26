//
//  OnBoardingViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/22/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class OnboardingViewController: BaseViewController {

	private let onboardingView = OnboardingView()
	private let viewModel = OnboardingViewModel()

	private let disposeBag = DisposeBag()
	private let viewList = [OnboardingStackViewController(), OnboardingStackViewController(), OnboardingStackViewController()]
	override func loadView() {
		self.view = onboardingView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setPageView()

		guard let first = viewList.first else { return }
		onboardingView.pageViewController.setViewControllers([first], direction: .forward, animated: true, completion: nil)

		viewList[0].imageView.image = .onboarding1
		viewList[0].titleLabel.text = "지도를 눌러 시작하기"
		viewList[0].subTitleLabel.text = "임장 하고 싶은 건물을 선택해 시작해보세요."

		viewList[1].imageView.image = .onboarding2
		viewList[1].titleLabel.text = "검색하기"
		viewList[1].subTitleLabel.text = "검색을 통해 찾고 싶은 건물을 손쉽게 검색해보세요."

		viewList[2].imageView.image = .onboarding3
		viewList[2].titleLabel.text = "임장하기"
		viewList[2].subTitleLabel.text = "내집마련에서 제공하는 체크리스트들로 임장을 시작해보세요."
	}

	override func configureBinding() {

		let input = OnboardingViewModel.Input(inputTap: onboardingView.skipButton.rx.tap)

		let output = viewModel.transform(input: input)

		output.outputTap.drive(with: self) { owner, value in
			if value == 3 {
				owner.view.window?.rootViewController = TabbarViewController()
				return
			}
			owner.onboardingView.configureTitle(value)
			owner.onboardingView.pageViewController.setViewControllers([owner.viewList[value]], direction: .forward, animated: true)
		}.disposed(by: disposeBag)
	}
}

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let currentIndex = viewList.firstIndex(of: viewController as! OnboardingStackViewController) else { return nil }
		return currentIndex <= 0 ? nil : viewList[currentIndex - 1]
	}

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let currentIndex = viewList.firstIndex(of: viewController as! OnboardingStackViewController) else { return nil }
		return currentIndex >= viewList.count - 1 ? nil : viewList[currentIndex + 1]
	}

	private func setPageView() {
		onboardingView.pageViewController.delegate = self
		onboardingView.pageViewController.dataSource = self
		onboardingView.pageViewController.view.isUserInteractionEnabled = false
	}

	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return viewList.count
	}

	func presentationIndex(for pageViewController: UIPageViewController) -> Int {
		return viewModel.currentPage
	}
}
