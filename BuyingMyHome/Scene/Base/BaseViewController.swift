//
//  BaseViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit
import Toast

class BaseViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureHierarchy()
		configureLayout()
		configureView()
		configureBinding()
	}

	func configureHierarchy() { }
	func configureLayout() { }
	func configureView() { }
	func configureBinding() { }

	enum ToastKind: String {
		case favoriteAdd = "관심코인에 등록하였습니다."
		case favoriteDelete = "관심코인에서 제거하였습니다."
		case errorAndRetry = "정보를 가져오는데에 실패하였습니다.\n15초 후 재시도 합니다."
		case searchResultIsEmpty = "검색결과가 없습니다."
		case decodingError = "검색이 불가능합니다."
		case serverError = "인터넷 연결을 확인해주세요."
		case favoriteError = "10개 이상 관심 코인에 등록할 수 없습니다."
	}

	func showToast(_ message: ToastKind, retry: String? = nil) {
		var style = ToastStyle()
		style.messageAlignment = .center
		var message = message.rawValue

		if let retry {
			message += "\n\(retry)초 후 데이터를 가져올 수 있습니다."
		}

		self.view.makeToast(message, style: style)
	}

}
