//
//  MapViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/7/24.
//

import UIKit

class MapViewController: BaseViewController {
	let mapView = MapView()

	override func loadView() {
		self.view = mapView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setSheet()
	}

	private func setSheet() {
		let sheetView = UINavigationController(rootViewController: BottomSheetViewController())
		sheetView.isModalInPresentation = true
		

		if let sheet = sheetView.sheetPresentationController {
			sheet.prefersGrabberVisible = true
			sheet.preferredCornerRadius = 30
			sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = false
			sheet.detents = [.custom(resolver: { context in
				0.05 * context.maximumDetentValue
			}), .medium(), .large()]
			sheet.largestUndimmedDetentIdentifier = .large
		}
		present(sheetView, animated: true)
	}
}
