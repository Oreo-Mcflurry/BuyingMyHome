//
//  MapView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/10/24.
//

import UIKit
import SnapKit
import MapKit

class MapView: BaseUIView {
	let map = MKMapView(frame: .zero)

	override func configureHierarchy() {
		[map].forEach { addSubview($0) }
	}

	override func configureLayout() {
		map.snp.makeConstraints {
			$0.edges.equalTo(self)
		}
	}


}
