//
//  OnboardingViewModel.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/28/24.
//

import Foundation
import RxSwift
import RxCocoa

final class OnboardingViewModel: InputOutputViewModelProtocol {

	var currentPage = 0

	struct Input {
		let inputTap: ControlEvent<Void>
	}

	struct Output {
		let outputTap: Driver<Int>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputTap = BehaviorRelay(value: currentPage)

		input.inputTap.bind(with: self) { owner, _ in
			owner.currentPage += 1
			if owner.currentPage == 3 {
				UserDefaults.standard[.isFirstRun] = true
			}
			outputTap.accept(owner.currentPage)
		}.disposed(by: disposeBag)

		return Output(outputTap: outputTap.asDriver())
	}
}
