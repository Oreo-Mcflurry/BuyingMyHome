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
	let checkListView = CheckListView()

	override func configureHierarchy() {
		addSubview(scrollView)
		scrollView.addSubview(contentView)
		[defaultInfoView, seperator, imageMemoView, seperator2, checkListView].forEach { contentView.addSubview($0) }
	}

	override func configureLayout() {
		scrollView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}

		contentView.snp.makeConstraints {
			$0.edges.equalTo(scrollView)
			$0.width.equalTo(scrollView)
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
			$0.top.equalTo(seperator.snp.bottom)
			$0.horizontalEdges.equalTo(contentView)
		}

		seperator2.snp.makeConstraints {
			$0.top.equalTo(imageMemoView.snp.bottom)
			$0.horizontalEdges.equalTo(contentView)
			$0.height.equalTo(10)
		}

		checkListView.snp.makeConstraints {
			$0.top.equalTo(imageMemoView.snp.bottom)
			$0.horizontalEdges.equalTo(contentView)
			$0.bottom.equalTo(contentView)
		}
	}


}

