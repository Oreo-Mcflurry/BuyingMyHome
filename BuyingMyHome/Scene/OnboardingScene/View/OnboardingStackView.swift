//
//  OnboardingStackView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/22/24.
//

import UIKit
import SnapKit

final class OnboardingStackViewController: BaseViewController {
	private let stackView = UIStackView()
	let imageView = UIImageView()
	let titleLabel = UILabel()
	let subTitleLabel = UILabel()

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureHierarchy() {
		view.addSubview(stackView)
		[imageView, titleLabel, subTitleLabel].forEach { stackView.addArrangedSubview($0) }
	}

	override func configureLayout() {
		stackView.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.width.equalToSuperview().inset(50)
		}
	}

	override func configureView() {
		imageView.contentMode = .scaleAspectFill
		titleLabel.font = .preferredFont(forTextStyle: .title1)

		subTitleLabel.font = .preferredFont(forTextStyle: .body)
		subTitleLabel.textAlignment = .center
		subTitleLabel.numberOfLines = 0

		stackView.axis = .vertical
		stackView.spacing = 20
		stackView.alignment = .fill
	}
}
