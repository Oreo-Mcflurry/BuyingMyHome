//
//  ViewModel.swift
//  SeSACRxThreads
//
//  Created by A_Mcflurry on 4/3/24.
//

import Foundation
import RxSwift

protocol InputOutputViewModelProtocol {
	associatedtype Input
	associatedtype Output

	var disposeBag: DisposeBag { get set }

	func transform(input: Input) -> Output
}
