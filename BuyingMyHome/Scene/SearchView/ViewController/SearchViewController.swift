//
//  SearchViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/15/24.
//

import UIKit

class SearchViewController: BaseViewController {

	let searchView = SearchView()
	let viewModel = SearchViewModel()

	override func loadView() {
		self.view = searchView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.searchController = searchView.searchController
	}
}
