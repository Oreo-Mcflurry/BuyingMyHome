//
//  BottomSheetViewController.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/11/24.
//

import UIKit

class BottomSheetViewController: BaseViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
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
