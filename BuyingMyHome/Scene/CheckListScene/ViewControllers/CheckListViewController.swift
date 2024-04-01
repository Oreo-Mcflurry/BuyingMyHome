//
//  CheckListView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/20/24.
//

import UIKit
import SnapKit
import Tabman
import Pageboy

final class CheckListViewController: TabmanViewController {
	var checkTypes: [Int] = [0,1,2]
	let enviromentCheckViewController = EnviromentCheckViewController()
	let insideCheckViewController = InsideCheckViewController()
	let schoolCheckViewController = SchoolCheckViewController()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.dataSource = self
		self.view.layoutSubviews()
		self.automaticallyAdjustsChildInsets = true
		let bar = TMBar.ButtonBar()
		bar.layout.transitionStyle = .snap
		bar.backgroundView.style = .blur(style: .light)
		bar.backgroundColor = .white
		addBar(bar, dataSource: self, at: .top)
	}
}

extension CheckListViewController: PageboyViewControllerDataSource, TMBarDataSource {
	 func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
		  return [enviromentCheckViewController, insideCheckViewController, schoolCheckViewController].count
	 }

	 func viewController(for pageboyViewController: PageboyViewController,
								at index: PageboyViewController.PageIndex) -> UIViewController? {
		  return [enviromentCheckViewController, insideCheckViewController, schoolCheckViewController][index]
	 }

	 func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
		  return nil
	 }

	 func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
		 let title = CheckListType.allCases[checkTypes[index]].title
		  return TMBarItem(title: title)
	 }
}
