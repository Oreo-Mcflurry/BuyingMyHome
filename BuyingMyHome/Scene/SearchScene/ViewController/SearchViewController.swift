//
//  SearchViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/15/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {

	private let searchView = SearchView()
	private let viewModel = SearchViewModel()
	private let disposeBag = DisposeBag()
	var didSelectcompletionHandler: ((SearchToMapDataPassingModel)->Void)?

	override func loadView() {
		self.view = searchView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setTableView()
	}

	override func configureView() {
		self.tabBarController?.tabBar.isHidden = true
		self.navigationItem.title = "검색"
	}

	override func configureBinding() {
		viewModel.didSelectOutput.bind { [weak self] value in
			guard let value else { return }
			self?.didSelectcompletionHandler?(value)
			self?.navigationController?.popViewController(animated: true)
		}

		viewModel.dataChangeOutput.bind(with: self) { owner, _ in
			owner.searchView.searchAndHistoryTableView.reloadData()
		}.disposed(by: disposeBag)

		viewModel.searchControllerPresentOutput.bind(with: self) { owner, _ in
			owner.searchView.searchAndHistoryTableView.reloadData()
		}.disposed(by: disposeBag)

		searchView.searchController.searchBar.rx.searchButtonClicked
			.withLatestFrom(searchView.searchController.searchBar.rx.text.orEmpty)
			.distinctUntilChanged()
			.bind(with: self) { owner, value in
				owner.viewModel.searchApiRequestInput.onNext(value)
			}.disposed(by: disposeBag)

		viewModel.searchApiRequestOutput.bind(with: self) { owner, value in
			if value != nil {
				owner.showToast(.searchError)
			} else  {
				owner.searchView.searchAndHistoryTableView.reloadData()
			}
		}.disposed(by: disposeBag)

		searchView.searchController.rx.willPresent.bind(with: self) { owner, _ in
			owner.viewModel.searchControllerPresentInput.onNext(.present)
		}.disposed(by: disposeBag)

		searchView.searchController.rx.willDismiss.bind(with: self) { owner, _ in
			owner.viewModel.searchControllerPresentInput.onNext(.dismiss)
		}.disposed(by: disposeBag)
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
			cell.deleteButton.rx.tap.bind(with: self) { owner, _ in
				owner.viewModel.deleteButtonInput.onNext(indexPath.row)
			}.disposed(by: cell.disposeBag)
			return cell
		}
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
			viewModel.pagingInput.onNext(searchView.searchController.searchBar.text!)
		}
	}
}
