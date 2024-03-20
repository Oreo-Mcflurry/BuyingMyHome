//
//  AddEditViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/18/24.
//

import UIKit

final class AddEditViewController: BaseViewController {

	let addEditViewModel = AddEditViewModel()
	let addEditView = AddEditView()

	override func loadView() {
		self.view = addEditView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		self.tabBarController?.tabBar.isHidden = true
	}
}
