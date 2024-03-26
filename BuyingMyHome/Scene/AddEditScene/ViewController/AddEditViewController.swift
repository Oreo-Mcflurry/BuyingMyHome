//
//  AddEditViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/18/24.
//

import UIKit
import RealmSwift

final class AddEditViewController: BaseViewController {

	let viewModel = AddEditViewModel()
	let addEditView = AddEditView()

	override func loadView() {
		self.view = addEditView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		let rightButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(tapSaveButton))
		addEditView.configureUI(viewModel.passingValue, viewModel.markerValue)
		navigationItem.rightBarButtonItem = rightButton
	}

	override func configureView() {
		self.tabBarController?.tabBar.isHidden = true
	}

	@objc private func tapSaveButton() {
		let enviromentList = List<Int?>()
		addEditView.checkListViewController.enviromentCheckViewController.enviromentCheck.forEach { enviromentList.append($0) }
		let schoolCheckList = List<Int?>()
		addEditView.checkListViewController.schoolCheckViewController.schoolCheck.forEach { schoolCheckList.append($0) }
		let insideCheckList = List<Int?>()
		addEditView.checkListViewController.insideCheckViewController.insideCheck.forEach { insideCheckList.append($0) }
		
		print(enviromentList)
		if let value = viewModel.passingValue {
			let newData = RealEstateProperty(symbol: addEditView.defaultInfoView.symbolTextField.text! ,
														address: value.address,
														lat: value.lat,
														lng: value.lng,
														usageType: 0,
														dong: addEditView.defaultInfoView.dongTextField.text!,
														ho: addEditView.defaultInfoView.hoTextField.text!,
														memo: addEditView.imageMemoView.memoTextField.text!,
														enviromentCheckLists: enviromentList,
														schoolCheckLists: schoolCheckList,
														insideCheckLists: insideCheckList)
			RealmDataManager().saveData(newData)
		} else if let value = viewModel.markerValue {
			do {
				let realm = try Realm()
				try realm.write {
					value.symbol = addEditView.defaultInfoView.symbolTextField.text!
					value.usageType = 0
					value.dong = addEditView.defaultInfoView.dongTextField.text!
					value.ho = addEditView.defaultInfoView.hoTextField.text!
					value.memo = addEditView.imageMemoView.memoTextField.text!
					value.enviromentCheckLists = enviromentList
					value.schoolCheckLists = schoolCheckList
					value.insideCheckLists = insideCheckList
				}
			} catch {
				print(error)
			}

//			RealmDataManager().update(value)
		}
		navigationController?.popViewController(animated: true)
	}
}

