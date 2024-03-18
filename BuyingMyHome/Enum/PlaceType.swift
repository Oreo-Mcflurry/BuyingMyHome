//
//  PlaceType.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/17/24.
//

import Foundation

enum PlaceType: String, CaseIterable {
	 case MT1
	 case CS2
	 case PS3
	 case SC4
	 case AC5
	 case PK6
	 case OL7
	 case SW8
	 case BK9
	 case CT1
	 case AG2
	 case PO3
	 case AT4
	 case AD5
	 case FD6
	 case CE7
	 case HP8
	 case PM9

	 func getTitle() -> String {
		  switch self {
		  case .MT1:
				return "대형마트"
		  case .CS2:
				return "편의점"
		  case .PS3:
				return "어린이집, 유치원"
		  case .SC4:
				return "학교"
		  case .AC5:
				return "학원"
		  case .PK6:
				return "주차장"
		  case .OL7:
				return "주유소, 충전소"
		  case .SW8:
				return "지하철역"
		  case .BK9:
				return "은행"
		  case .CT1:
				return "문화시설"
		  case .AG2:
				return "중개업소"
		  case .PO3:
				return "공공기관"
		  case .AT4:
				return "관광명소"
		  case .AD5:
				return "숙박"
		  case .FD6:
				return "음식점"
		  case .CE7:
				return "카페"
		  case .HP8:
				return "병원"
		  case .PM9:
				return "약국"
		  }
	 }
}
