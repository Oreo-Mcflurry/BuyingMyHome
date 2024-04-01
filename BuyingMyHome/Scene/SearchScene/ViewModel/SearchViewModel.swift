//
//  SearchViewModel.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/15/24.
//

import Foundation
import UIKit.UICollectionView
import RealmSwift
import RxSwift
import RxCocoa

final class SearchViewModel {

	enum SearchControllerPresent {
		case present
		case dismiss
	}

	private var page = 1
	private var realmManager = RealmDataManager()
	let disposeBag = DisposeBag()

	var searchResult: KakaoSearchModel?

	var searchHistory: Results<SearchHistoryModel>!

	var isPresentSearchController: SearchControllerPresent = .dismiss

	let didSelectInput: Observable<Int?> = Observable(nil)
	let didSelectOutput: Observable<SearchToMapDataPassingModel?> = Observable(nil)

//	let searchControllerPresentInput: Observable<SearchControllerPresent?> = Observable(nil)
//	let searchControllerPresentOutput: Observable<Void?> = Observable(nil)

	let searchControllerPresentInput = PublishSubject<SearchControllerPresent>()
	let searchControllerPresentOutput = PublishSubject<Void>()

	let searchInput: Observable<String?> = Observable(nil)
	let searchOutput: Observable<RequestManager.APIError?> = Observable(nil)

	let pagingInput: Observable<String?> = Observable(nil)
	let pagingOutput: Observable<Void?> = Observable(nil)

	let didChangeInput: Observable<Void?> = Observable(nil)
	let didChangeOutput: Observable<Void?> = Observable(nil)

	let deleteButtonInput: Observable<Int?> = Observable(nil)
	let deleteButtonOutput: Observable<Void?> = Observable(nil)

	init() {
		searchHistory = realmManager.fetchData(SearchHistoryModel.self).sorted(byKeyPath: SearchHistoryModel.sortedProperty, ascending: false)

		didSelectInput.bind { [weak self] value in
			self?.didSelectAction(value)
		}

		searchControllerPresentInput.bind(with: self) { owner, value in
			owner.isPresentSearchController = value
			owner.searchControllerPresentOutput.onNext(())

			if case .dismiss = owner.isPresentSearchController {
				owner.searchOutput.value = (nil)
			}
		}.disposed(by: disposeBag)

		searchInput.bind { [weak self] value in
			guard let value else { return }
			self?.searchToKakao(searchText: value)
		}

		pagingInput.bind { [weak self] value in
			guard let value else { return }
			self?.pagingSearch(searchText: value)
		}

		didChangeInput.bind { [weak self] _ in
			self?.searchOutput.value = (nil)
			self?.didChangeOutput.value = ()
		}

		deleteButtonInput.bind { [weak self] value in
			guard let value else { return }
			guard let self else { return }
			self.realmManager.deleteData(self.searchHistory[value])
			deleteButtonOutput.value = ()
		}
	}

	private func didSelectAction(_ value: Int?) {
		guard let value else { return }

		switch isPresentSearchController {
		case .present:
			guard let item = self.searchResult?.documents[value] else { return }
			RequestManager().request(.naverGeocoding(address: "\(item.roadAddressName) \(item.placeName)"), NaverGeocodingModel.self) { [weak self] result, error in
				guard let result else { return }
				self?.didSelectOutput.value = SearchToMapDataPassingModel(from: result)
				self?.saveAndDelete(SearchToMapDataPassingModel(from: result))
			}
		case .dismiss:
			self.didSelectOutput.value = SearchToMapDataPassingModel(from: searchHistory[value])
			self.saveAndDelete(SearchToMapDataPassingModel(from: searchHistory[value]))
		}
	}

	private func saveAndDelete(_ data: SearchToMapDataPassingModel) {
		realmManager.deleteDuplicate(data)
		realmManager.saveData(SearchHistoryModel(from: data))
	}

	var numberOfRowsInSection: Int {
		switch isPresentSearchController {
		case .present:
			return searchResult?.documents.count ?? 0
		case .dismiss:
			return searchHistory.count
		}
	}

	private func searchToKakao(searchText: String) {
		page = 1
		RequestManager().request(.kakaoSearch(searchText: searchText, page: page), KakaoSearchModel.self) { [weak self] result, error in
			self?.searchResult = result
			self?.searchOutput.value = (error)
		}
	}

	private func pagingSearch(searchText: String) {
		if let value = searchResult?.meta.isEnd, value { return }
		page += 1
		RequestManager().request(.kakaoSearch(searchText: searchText, page: page), KakaoSearchModel.self) { [weak self] result, error in
			self?.searchResult?.documents.append(contentsOf: result?.documents ?? [])
			self?.searchResult?.meta.isEnd = result?.meta.isEnd ?? true
			self?.pagingOutput.value = ()
		}
	}
}
