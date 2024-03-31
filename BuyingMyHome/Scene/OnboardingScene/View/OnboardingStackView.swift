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
			$0.edges.equalToSuperview()
		}
	}

	override func configureView() {
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.distribution = .equalCentering
		stackView.spacing = 15

		imageView.contentMode = .scaleAspectFit
		titleLabel.font = .boldSystemFont(ofSize: 25)
		titleLabel.textAlignment = .center

		subTitleLabel.font = .systemFont(ofSize: 16)
		subTitleLabel.textColor = .gray
		subTitleLabel.textAlignment = .center
		subTitleLabel.numberOfLines = 0
	}
}
