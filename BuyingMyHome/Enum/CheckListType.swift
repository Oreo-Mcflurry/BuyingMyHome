//
//  CheckListType.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/22/24.
//

import Foundation

enum CheckListType: Int, CaseIterable {
	case enviroment
	case inside
	case school
	case reconstruction
	case newConstruction
	case aution

	var title: String {
		switch self {
		case .enviroment:
			return "환경"
		case .inside:
			return "실내"
		case .school:
			return "학군"
		case .reconstruction:
			return "재건축"
		case .newConstruction:
			return "신축"
		case .aution:
			return "경매"
		}
	}
}
