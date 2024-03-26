//
//  ArchiveViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/24/24.
//

import UIKit
import SnapKit
import RealmSwift

class ArchiveViewController: BaseViewController {
	private var savedData: Results<RealEstateProperty>!
	private let tableView = UITableView()
	private var token : NotificationToken?

	override func viewDidLoad() {
		super.viewDidLoad()
		setTableView()
		savedData = RealmDataManager().fetchData(RealEstateProperty.self)
		token = savedData.observe { [weak self] change in
			switch change {
			case .initial, .update: self?.tableView.reloadData()
			case .error: break
			}
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = false
	}

	override func configureHierarchy() {
		view.addSubview(tableView)
	}

	override func configureLayout() {
		tableView.snp.makeConstraints {
			$0.edges.equalTo(view)
		}
	}

	override func configureView() {
		navigationItem.title = "Archive"
	}
}

extension ArchiveViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return savedData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		var content = cell.defaultContentConfiguration()

		content.text = savedData[indexPath.row].symbol
		content.secondaryText = savedData[indexPath.row].address

		cell.contentConfiguration = content
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = AddEditViewController()
		vc.viewModel.markerValue = savedData[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
		tableView.reloadRows(at: [indexPath], with: .automatic)
	}

	private func setTableView() {
		tableView.dataSource = self
		tableView.delegate = self
	}
}
