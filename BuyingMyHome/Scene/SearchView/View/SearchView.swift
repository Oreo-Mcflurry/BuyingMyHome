//
//  SearchView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/15/24.
//

import UIKit
import SnapKit

class SearchView: BaseUIView {
	let resultView = SearchResultViewContoller()
	lazy var searchController = UISearchController(searchResultsController: resultView)
}
