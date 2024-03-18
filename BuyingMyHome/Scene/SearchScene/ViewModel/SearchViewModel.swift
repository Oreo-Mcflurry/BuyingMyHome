//
//  SearchViewModel.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/15/24.
//

import Foundation
import UIKit.UICollectionView
import RealmSwift

final class SearchViewModel {

	enum SearchControllerPresent {
		case present
		case dismiss
	}

	private var page = 1
	private var realmManager = RealmDataManager()

	var searchHistory: Results<SearchHistoryModel>!

	var isPresentSearchController: SearchControllerPresent = .dismiss

	let didSelectInput: Observable<KakaoSearchResult?> = Observable(nil)
	let didSelectOutput: Observable<KakaoSearchResult?> = Observable(nil)

	let searchControllerPresentInput: Observable<SearchControllerPresent?> = Observable(nil)
	let searchControllerPresentOutput: Observable<Void?> = Observable(nil)

	let searchInput: Observable<String?> = Observable(nil)
	let searchOutput: Observable<(KakaoSearchModel?, RequestManager.APIError?)> = Observable((nil,nil))

	let pagingInput: Observable<String?> = Observable(nil)
	let pagingOutput: Observable<Void?> = Observable(nil)

	let didChangeInput: Observable<Void?> = Observable(nil)
	let didChangeOutput: Observable<Void?> = Observable(nil)

	let deleteButtonInput: Observable<Int?> = Observable(nil)
	let deleteButtonOutput: Observable<Void?> = Observable(nil)

	init() {
		searchHistory = realmManager.fetchData(SearchHistoryModel.self).sorted(byKeyPath: SearchHistoryModel.sortedProperty, ascending: false)

		didSelectInput.bind { [weak self] value in
			self?.didSelectOutput.value = value
			self?.didSelectAction(value)
		}

		searchControllerPresentInput.bind { [weak self] value in
			guard let value else { return }
			self?.isPresentSearchController = value
			self?.searchControllerPresentOutput.value = ()
			if case .dismiss = self?.isPresentSearchController {
				self?.searchOutput.value = (nil,nil)
			}
		}

		searchInput.bind { [weak self] value in
			guard let value else { return }
			self?.searchToKakao(searchText: value)
		}

		pagingInput.bind { [weak self] value in
			guard let value else { return }
			self?.pagingSearch(searchText: value)
		}

		didChangeInput.bind { [weak self] _ in
			self?.searchOutput.value = (nil,nil)
			self?.didChangeOutput.value = ()
		}

		deleteButtonInput.bind { [weak self] value in
			guard let value else { return }
			guard let self else { return }
			self.realmManager.deleteData(self.searchHistory[value])
			deleteButtonOutput.value = ()
		}
	}

	func didSelectAction(_ value: KakaoSearchResult?) {
		guard let value else { return }
		realmManager.deleteDuplicate(value)
		realmManager.saveData(SearchHistoryModel(from: value))
	}

	var numberOfRowsInSection: Int {
		switch isPresentSearchController {
		case .present:
			return searchOutput.value.0?.documents.count ?? 0
		case .dismiss:
			return searchHistory.count
		}
	}

	private func searchToKakao(searchText: String) {
		page = 1
		RequestManager().request(.kakaoSearch(searchText: searchText, page: page), KakaoSearchModel.self) { [weak self] result, error in
			self?.searchOutput.value = (result, error)
		}
	}

	private func pagingSearch(searchText: String) {
		if let value = searchOutput.value.0?.meta.isEnd, value { return }
		page += 1
		RequestManager().request(.kakaoSearch(searchText: searchText, page: page), KakaoSearchModel.self) { [weak self] result, error in
			self?.searchOutput.value.0?.documents.append(contentsOf: result?.documents ?? [])
			self?.searchOutput.value.0?.meta.isEnd = result?.meta.isEnd ?? false
			self?.pagingOutput.value = ()
		}
	}
}
