//
//  AddEditView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/18/24.
//

import UIKit
import SnapKit
import Tabman
import Pageboy

final class AddEditView: BaseUIView {
	let scrollView = UIScrollView()
	let contentView = UIView()

	let defaultInfoView = DefaultInfoView()
	let seperator = SeperatorView()
	let imageMemoView = ImageMemoView()
	let seperator2 = SeperatorView()
	let checkListViewController = CheckListViewController()

	override func configureHierarchy() {
		addSubview(scrollView)
		scrollView.addSubview(contentView)
		[defaultInfoView, seperator, imageMemoView, seperator2].forEach { contentView.addSubview($0) }
		contentView.inputViewController?.addChild(checkListViewController)
		contentView.addSubview(checkListViewController.view)
		checkListViewController.didMove(toParent: contentView.inputViewController)
	}

	override func configureLayout() {
		scrollView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}

		contentView.snp.makeConstraints {
			$0.edges.equalTo(scrollView)
			$0.width.equalTo(scrollView)
			$0.height.greaterThanOrEqualTo(1150)
		}

		defaultInfoView.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(contentView)
			$0.height.equalTo(320)
		}

		seperator.snp.makeConstraints {
			$0.top.equalTo(defaultInfoView.snp.bottom)
			$0.horizontalEdges.equalTo(contentView)
			$0.height.equalTo(10)
		}

		imageMemoView.snp.makeConstraints {
			$0.top.equalTo(seperator.snp.bottom).offset(betweenPadding)
			$0.horizontalEdges.equalTo(contentView)
			$0.height.equalTo(100)
		}

		seperator2.snp.makeConstraints {
			$0.top.equalTo(imageMemoView.snp.bottom)
			$0.horizontalEdges.equalTo(contentView)
			$0.height.equalTo(10)
		}

		checkListViewController.view.snp.makeConstraints {
			$0.top.equalTo(seperator2.snp.bottom)
			$0.horizontalEdges.equalTo(contentView).inset(defaultPadding)
			$0.bottom.greaterThanOrEqualTo(contentView)
		}
	}

	override func configureView() {
		scrollView.autoresizingMask = [.flexibleHeight]
	}

	func configureUI(_ passingValue: SearchToMapDataPassingModel?, _ markerValue: RealEstateProperty?) {
		if let passingValue {
			defaultInfoView.addressTextField.text = passingValue.address
			defaultInfoView.symbolTextField.text = passingValue.symbol
		} else if let markerValue {
			defaultInfoView.addressTextField.text = markerValue.address
			defaultInfoView.symbolTextField.text = markerValue.symbol
			imageMemoView.memoTextField.text = markerValue.memo
			checkListViewController.enviromentCheckViewController.enviromentCheck = markerValue.enviromentCheckArray.isEmpty ? [nil, nil, nil, nil, nil, nil, nil, nil] : markerValue.enviromentCheckArray
			checkListViewController.insideCheckViewController.insideCheck = markerValue.insideCheckArray.isEmpty ? [nil, nil, nil, nil, nil, nil, nil, nil] : markerValue.insideCheckArray
			checkListViewController.schoolCheckViewController.schoolCheck = markerValue.schoolCheckArray.isEmpty ? [nil, nil, nil, nil, nil, nil, nil, nil] : markerValue.schoolCheckArray
		}
	}
}

