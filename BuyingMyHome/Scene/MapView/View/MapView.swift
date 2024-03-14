//
//  MapView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/13/24.
//

import UIKit
import SnapKit
import NMapsMap

final class MapView: BaseUIView {
	let naverMap = NMFNaverMapView(frame: .zero)
	private let infoView = MapTapInfoView()
	let searchButton = UIButton(configuration: .filled())

	override func configureHierarchy() {
		[naverMap, searchButton].forEach { addSubview($0) }
	}

	override func configureLayout() {
		naverMap.snp.makeConstraints {
			$0.edges.equalTo(self)
		}

		searchButton.snp.makeConstraints {
			$0.top.trailing.equalTo(self.safeAreaLayoutGuide).inset(defautPadding)
		}
	}

	override func configureView() {
		naverMap.showCompass = true
		naverMap.showScaleBar = true
	}

	func isInfoViewAppear(_ value: Bool) {
		if value {
			addSubview(infoView)
			infoView.snp.makeConstraints {
				$0.bottom.equalTo(self.safeAreaLayoutGuide).inset(verticalPadding)
				$0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(defautPadding)
			}
		} else {
			infoView.removeFromSuperview()
		}
	}

	func configureUI(_ info: (symbol: String, address: String)) {
		infoView.addressLabel.text = info.address
		infoView.symbolLabel.text = info.symbol
	}
}
