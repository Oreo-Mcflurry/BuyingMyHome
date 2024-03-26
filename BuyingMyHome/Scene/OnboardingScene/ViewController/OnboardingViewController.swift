//
//  OnBoardingViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/22/24.
//

import UIKit
import SnapKit

final class OnboardingViewController: BaseViewController {

	private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
	private let skipButton = UIButton()
	private let viewList = [OnboardingStackViewController(), OnboardingStackViewController(), OnboardingStackViewController()]
	private var chooseIndex = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		setPageView()
	}

	override func configureHierarchy() {
		view.addSubview(pageViewController.view)
		view.addSubview(skipButton)


		guard let first = viewList.first else { return }
		pageViewController.setViewControllers([first], direction: .forward, animated: true, completion: nil)
	}

	override func configureLayout() {
		skipButton.snp.makeConstraints {
			$0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
			$0.height.equalTo(45)
		}

		pageViewController.view.snp.makeConstraints {
			$0.bottom.equalTo(skipButton.snp.top).offset(-20)
			$0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
		}
	}

	override func configureView() {
		skipButton.setTitle("시작하기!", for: .normal)
		skipButton.backgroundColor = .accent
		skipButton.layer.cornerRadius = 10

		skipButton.addTarget(self, action: #selector(tapSkipButton), for: .touchUpInside)

		UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.accent
		UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray
	}

	@objc private func tapSkipButton() {
		UserDefaults.standard[.isFirstRun] = true
		let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
		let sceneDelgate = windowScene?.delegate as? SceneDelegate
		let vc = TabbarViewController()
		sceneDelgate?.window?.rootViewController = vc
		sceneDelgate?.window?.makeKeyAndVisible()
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
		pageViewController.delegate = self
		pageViewController.dataSource = self
	}

	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return viewList.count
	}

	func presentationIndex(for pageViewController: UIPageViewController) -> Int {
		return 0
	}
}
