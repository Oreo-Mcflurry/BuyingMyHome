//
//  MapViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/7/24.
//

import UIKit

class MapViewController: BaseViewController, UIAdaptivePresentationControllerDelegate {
	let mapView = MapView()

	override func loadView() {
		self.view = mapView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		let presentationController = self.presentationController(forPresented: self, source: BottomSheetViewController())

	}

}

class TabSheetPresentationController : UISheetPresentationController {
	 override func presentationTransitionWillBegin() {
		  super.presentationTransitionWillBegin()

		  // Update the container frame if there is a tab bar
		  if let tc = presentingViewController as? UITabBarController, let cv = containerView {
				cv.clipsToBounds = true // ensure tab bar isn't covered
				var frame = cv.frame
				frame.size.height -= tc.tabBar.frame.height
				cv.frame = frame
		  }
	 }
}

extension MapViewController: UIViewControllerTransitioningDelegate {
	 func presentationController(forPresented presented: UIViewController, source: UIViewController) -> UIPresentationController? {
		  let sc = TabSheetPresentationController(presentedViewController: presented, presenting: source)
		  sc.detents = [
				.mySmall(),
				.medium(),
				.myLarge(),
		  ]
		  sc.largestUndimmedDetentIdentifier = .myLarge
		  sc.prefersGrabberVisible = true
		  sc.prefersScrollingExpandsWhenScrolledToEdge = false
		  sc.widthFollowsPreferredContentSizeWhenEdgeAttached = true
		  sc.selectedDetentIdentifier = .medium

		  return sc
	 }
}

extension UISheetPresentationController.Detent.Identifier {
	 static let mySmall = UISheetPresentationController.Detent.Identifier("mySmall")
	 static let myLarge = UISheetPresentationController.Detent.Identifier("myLarge")
}

extension UISheetPresentationController.Detent {
	 class func mySmall() -> UISheetPresentationController.Detent {
		  return UISheetPresentationController.Detent.custom(identifier: .mySmall) { context in
				return 60
		  }
	 }

	 class func myLarge() -> UISheetPresentationController.Detent {
		  return UISheetPresentationController.Detent.custom(identifier: .myLarge) { context in
				return context.maximumDetentValue - 0.1
		  }
	 }
}
