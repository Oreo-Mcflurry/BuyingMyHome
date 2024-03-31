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
		viewList[0].imageView.backgroundColor = .red
		viewList[0].titleLabel.text = "Test"
		viewList[0].subTitleLabel.text = "Test"
	}

	override func configureBinding() {
		onboardingView.skipButton.rx.tap.bind(with: self) { owner, _ in
			owner.viewModel.nextButtonClicked(owner)

		}.disposed(by: disposeBag)

		viewModel.currentPage.bind(with: self) { owner, value in
			owner.onboardingView.configureTitle(value)
			owner.onboardingView.pageViewController.setViewControllers([owner.viewList[value]], direction: .forward, animated: true)
		}.disposed(by: disposeBag)
	}
}

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let currentIndex = viewList.firstIndex(of: viewController as! OnboardingStackViewController) else { return nil }
		viewModel.currentPage.onNext(currentIndex)
		return currentIndex <= 0 ? nil : viewList[currentIndex - 1]
	}

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let currentIndex = viewList.firstIndex(of: viewController as! OnboardingStackViewController) else { return nil }
		viewModel.currentPage.onNext(currentIndex)
		return currentIndex >= viewList.count - 1 ? nil : viewList[currentIndex + 1]
	}

	private func setPageView() {
		onboardingView.pageViewController.delegate = self
		onboardingView.pageViewController.dataSource = self
	}

	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return viewList.count
	}

	func presentationIndex(for pageViewController: UIPageViewController) -> Int {
		return viewModel.currentIndex
	}
}
