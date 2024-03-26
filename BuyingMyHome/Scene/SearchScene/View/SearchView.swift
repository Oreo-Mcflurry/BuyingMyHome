//
//  SearchView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/15/24.
//

import UIKit
import SnapKit

final class SearchView: BaseUIView {
	let searchController = UISearchController(searchResultsController: nil)
	lazy var searchAndHistoryTableView = UITableView(frame: .zero)

	override func configureHierarchy() {
		self.addSubview(searchAndHistoryTableView)
	}

	override func configureLayout() {
		searchAndHistoryTableView.snp.makeConstraints {
			$0.edges.equalTo(self.safeAreaLayoutGuide)
			searchAndHistoryTableView.tableHeaderView = searchController.searchBar
		}
	}

	override func configureView() {
		searchController.searchBar.placeholder = "주소, 건물, 지역을 검색하세요."
	}
}
