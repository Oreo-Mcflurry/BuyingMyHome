//
//  SettingView.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/15/24.
//

import SwiftUI

struct SettingView: View {
	var body: some View {
		List {
		  NavigationLink {
			  Text("123123")
		  } label: {
			  Text("23123")
		  }

	  }
	  .listStyle(.inset)
	  .navigationTitle("설정")
	  .navigationBarTitleDisplayMode(.large)
	}
}

#Preview {
	SettingView()
}
