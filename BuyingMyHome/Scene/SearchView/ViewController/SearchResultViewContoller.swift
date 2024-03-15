//
//  SearchResultView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/15/24.
//

import UIKit
import SnapKit

class SearchResultViewContoller: BaseViewController {

	let resultTableView = UITableView()
	let viewModel = SearchViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension SearchResultViewContoller: UITableViewDelegate, UITableViewDataSource {

	private func setTableView() {
		resultTableView.delegate = self
		resultTableView.dataSource = self
		resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.resultNumberOfRowsInSection
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
		cell.contentConfiguration = setConfgiguration()
		return cell
	}

	private func setConfgiguration() -> UIListContentConfiguration {
		var configuration = UITableViewCell().defaultContentConfiguration()
		configuration.text = ""

		return configuration
	}
}
