//
//  MapView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/13/24.
//

import UIKit
import SnapKit
import NMapsMap

class MapView: BaseUIView {
	let naverMap = NMFNaverMapView(frame: .zero)

	override func configureHierarchy() {
		[naverMap].forEach { addSubview($0) }
	}

	override func configureLayout() {
		naverMap.snp.makeConstraints {
			$0.edges.equalTo(self)
		}
	}

	override func configureView() {
		naverMap.showCompass = true
		naverMap.showScaleBar = true
		
	}
}
