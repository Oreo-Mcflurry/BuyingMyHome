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
		setTabbarViewControllers()
		configureTabbarDesign()
	}

	private func setTabbarViewControllers() {
		let mapVC = UINavigationController(rootViewController: MapViewController())
		mapVC.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "star"), tag: 0)


//		let searchVC = UINavigationController(rootViewController: DaumZipCodeViewController())
//		searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "star"), tag: 1)

//		let favoriteVC = UINavigationController(rootViewController: FavoriteViewController())
//		favoriteVC.tabBarItem = UITabBarItem(title: nil, image: .tabPortfolioInactive, selectedImage: .tabPortfolio)
//
//		let profileVC = UINavigationController(rootViewController: ProfileViewController())
//		profileVC.tabBarItem = UITabBarItem(title: nil, image: .tabUserInactive, selectedImage: .tabUser)

		self.viewControllers = [mapVC]
	}

	private func configureTabbarDesign() {
		tabBar.layer.cornerRadius = tabBar.frame.height * 0.41
		tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		tabBar.backgroundColor = .white
	}

	
}
