//
//  TabbarViewController.swift
//  SeSAC-Recap2
//
//  Created by A_Mcflurry on 2/27/24.
//

import UIKit
import SwiftUI

final class TabbarViewController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setTabbarViewControllers()
		configureTabbarDesign()
	}

	private func setTabbarViewControllers() {
		let mapVC = UINavigationController(rootViewController: MapViewController())
		mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))

		let archiveVC = UINavigationController(rootViewController: ArchiveViewController())
		archiveVC.tabBarItem = UITabBarItem(title: "Archive", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))

		self.viewControllers = [mapVC, archiveVC]
	}

	private func configureTabbarDesign() {
		tabBar.layer.cornerRadius = tabBar.frame.height * 0.41
		tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		tabBar.backgroundColor = .white
		tabBar.layer.borderColor = UIColor.systemGray5.cgColor
		tabBar.layer.borderWidth = 1
		tabBar.layer.shadowColor = UIColor.black.cgColor
		tabBar.layer.shadowOpacity = 0.2
		tabBar.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
	}

	
}
