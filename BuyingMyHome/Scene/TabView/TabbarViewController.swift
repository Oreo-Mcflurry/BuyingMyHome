//
//  TabbarViewController.swift
//  SeSAC-Recap2
//
//  Created by A_Mcflurry on 2/27/24.
//

import UIKit

class TabbarViewController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		let homeVC = UINavigationController(rootViewController: ())
		homeVC.tabBarItem = UITabBarItem(title: nil, image: .tabTrendInactive, selectedImage: .tabTrend)

		let searchVC = UINavigationController(rootViewController: SearchViewController())
		searchVC.tabBarItem = UITabBarItem(title: nil, image: .tabSearchInactive, selectedImage: .tabSearch)

		let favoriteVC = UINavigationController(rootViewController: FavoriteViewController())
		favoriteVC.tabBarItem = UITabBarItem(title: nil, image: .tabPortfolioInactive, selectedImage: .tabPortfolio)

		let profileVC = UINavigationController(rootViewController: ProfileViewController())
		profileVC.tabBarItem = UITabBarItem(title: nil, image: .tabUserInactive, selectedImage: .tabUser)

		self.viewControllers = [homeVC, searchVC, favoriteVC, profileVC]
	}
}
