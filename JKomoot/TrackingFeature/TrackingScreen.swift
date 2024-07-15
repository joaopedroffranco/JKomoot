//
//  TrackingScreen.swift
//  JKomoot
//
//  Created by Joao Pedro Franco on 12/07/24.
//

import SwiftUI
import JUI

struct TrackingScreen: View {
	@ObservedObject var viewModel: TrackingViewModel
	
	init(viewModel: TrackingViewModel) {
		self.viewModel = viewModel
	}
	
	var body: some View {
		JList(data: viewModel.trackingImages) { element in
			JImageCell(image: .local(name: element))
		}
		.task { viewModel.start() }
		.frame(maxWidth: .infinity)
	}
}

struct TrackingScreen_Previews: PreviewProvider {
	static var previews: some View {
		TrackingScreen(
			viewModel: TrackingViewModel()
		)
	}
}
