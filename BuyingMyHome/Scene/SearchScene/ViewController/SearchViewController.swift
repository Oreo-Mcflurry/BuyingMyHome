//
//  SearchViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/15/24.
//

import UIKit

final class SearchViewController: BaseViewController {

	let searchView = SearchView()
	let viewModel = SearchViewModel()
	var completionHandler: ((SearchToMapDataPassingModel)->Void)?

	override func loadView() {
		self.view = searchView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setTableView()
		setSearchController()
		setSeachbar()
	}

	override func configureView() {
		self.tabBarController?.tabBar.isHidden = true
		self.navigationItem.title = "검색"
	}

	override func configureBinding() {
		viewModel.didSelectOutput.bind { [weak self] value in
			guard let value else { return }
			self?.completionHandler?(value)
			self?.navigationController?.popViewController(animated: true)
		}

		viewModel.searchControllerPresentOutput.bind { [weak self] value in
			self?.searchView.searchAndHistoryTableView.reloadData()
		}

		viewModel.searchOutput.bind { [weak self] value in
			if value != nil {
				self?.showToast(.searchError)
			} else  {
				self?.searchView.searchAndHistoryTableView.reloadData()
			}
		}

		viewModel.pagingOutput.bind { [weak self] _ in
			self?.searchView.searchAndHistoryTableView.reloadData()
		}

		viewModel.didChangeOutput.bind { [weak self] _ in
			self?.searchView.searchAndHistoryTableView.reloadData()
		}

		viewModel.deleteButtonOutput.bind { [weak self] _ in
			self?.searchView.searchAndHistoryTableView.reloadData()
		}
	}
}

extension SearchViewController: UISearchBarDelegate {
	private func setSeachbar() {
		searchView.searchController.searchBar.delegate = self
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		viewModel.searchInput.value = searchBar.text
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		viewModel.didChangeInput.value = ()
	}
}

extension SearchViewController: UISearchControllerDelegate {
	private func setSearchController() {
		searchView.searchController.delegate = self
	}

	func presentSearchController(_ searchController: UISearchController) {
		viewModel.searchControllerPresentInput.value = .present
	}

	func didDismissSearchController(_ searchController: UISearchController) {
		viewModel.searchControllerPresentInput.value = .dismiss
	}
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.didSelectInput.value = indexPath.row
		searchView.searchController.isActive = false
		navigationController?.popViewController(animated: true)
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRowsInSection
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		switch viewModel.isPresentSearchController {
		case .present:
			let cell = UITableViewCell()
			cell.contentConfiguration = configureCell(withData: viewModel.searchResult?.documents[indexPath.row], cell)
			return cell

		case .dismiss:
			let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.description(), for: indexPath) as! SearchHistoryTableViewCell
			cell.configurationCell(viewModel.searchHistory[indexPath.row])
			cell.deleteButton.addTarget(self, action: #selector(deleteButtonCliced), for: .touchUpInside)
			cell.deleteButton.tag = indexPath.row
			return cell
		}
	}

	@objc func deleteButtonCliced(sender: UIButton) {
		viewModel.deleteButtonInput.value = sender.tag
	}

	private func setTableView() {
		searchView.searchAndHistoryTableView.delegate = self
		searchView.searchAndHistoryTableView.dataSource = self
		searchView.searchAndHistoryTableView.prefetchDataSource = self
		searchView.searchAndHistoryTableView.register(SearchHistoryTableViewCell.self, forCellReuseIdentifier: SearchHistoryTableViewCell.description())
	}

	private func configureCell(withData data: KakaoSearchResult?,_ cell: UITableViewCell) -> UIContentConfiguration {
		var content = cell.defaultContentConfiguration()
		guard let data else { return content }

		content.text = data.placeName
		content.secondaryText = data.roadAddressName
		return content
	}
}

extension SearchViewController: UITableViewDataSourcePrefetching {
	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		if let count = viewModel.searchResult?.documents.count, indexPaths.contains(where: { $0.row == count-1 }) {
			viewModel.pagingInput.value = searchView.searchController.searchBar.text
		}
	}
}
