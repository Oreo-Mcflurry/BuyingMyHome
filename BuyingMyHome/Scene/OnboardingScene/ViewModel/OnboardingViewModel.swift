//
//  OnboardingViewModel.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/28/24.
//

import Foundation
import RxSwift
import RxCocoa

final class OnboardingViewModel {

	let currentPage = BehaviorSubject(value: 0)

	var currentIndex: Int {
		do {
			return try currentPage.value()
		} catch {
			return 0
		}
	}

	func nextButtonClicked(_ owner: OnboardingViewController) {
		if currentIndex == 2 {
			owner.view.window?.rootViewController = TabbarViewController()
			UserDefaults.standard[.isFirstRun] = true
		} else {
			currentPage.onNext(currentIndex+1)
		}
	}
}
