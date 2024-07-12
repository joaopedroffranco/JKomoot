//
//  TrackingScreen.swift
//  JKomoot
//
//  Created by Joao Pedro Franco on 12/07/24.
//

import SwiftUI

struct TrackingScreen: View {
	var viewModel: TrackingViewModel
	
	init(viewModel: TrackingViewModel) {
		self.viewModel = viewModel
	}

	var body: some View {
		Text("Hello, Tracking")
	}
}

struct TrackingScreen_Previews: PreviewProvider {
	static var previews: some View {
		TrackingScreen(viewModel: TrackingViewModel())
	}
}
