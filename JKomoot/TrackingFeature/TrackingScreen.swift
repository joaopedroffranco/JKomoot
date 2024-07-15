//
//  Created by Joao Pedro Franco on 12/07/24.
//

import SwiftUI
import JUI
import JFoundation

enum TrackingScreenState {
	case idle
	case data([ImageType])
	case error(String)
}

struct TrackingScreen: View {
	@ObservedObject var viewModel: TrackingViewModel
	
	init(viewModel: TrackingViewModel) {
		self.viewModel = viewModel
	}
	
	var body: some View {
		content
			.task { viewModel.onAppear() }
			.onDisappear { ImageCache.clean() }
	}
	
	@ViewBuilder
	private var content: some View {
		switch viewModel.state {
		case let .error(message):
			Text(message)
				.foregroundColor(DesignSystem.Colors.dark)
				.font(DesignSystem.Fonts.default)
				.multilineTextAlignment(.center)
		case let .data(images) where images.isEmpty:
			Text("Waiting for location updates...")
				.foregroundColor(DesignSystem.Colors.dark)
				.font(DesignSystem.Fonts.default)
				.multilineTextAlignment(.center)
		case let .data(images):
			JList(data: images, spacing: DesignSystem.Spacings.xs) { element in
				JImageCell(image: element)
					.frame(height: 250)
					.frame(maxWidth: .infinity)
			}
			.padding(DesignSystem.Spacings.xs)
		case .idle:
			Text("Loading...")
				.foregroundColor(DesignSystem.Colors.dark)
				.font(DesignSystem.Fonts.default)
		}
	}
}

struct TrackingScreen_Previews: PreviewProvider {
	static let viewModel1 = TrackingViewModel()
	static let viewModel2 = TrackingViewModel()
	static let viewModel3 = TrackingViewModel()
	
	static var previews: some View {
		Group {
			TrackingScreen(
				viewModel: viewModel1
			)
			.task {
				viewModel1.state = .data([
					.local("placeholder"),
					.local("placeholder"),
					.local("placeholder")
				])
			}
			
			TrackingScreen(
				viewModel: viewModel1
			)
			.task { viewModel1.state = .data([]) }
			
			TrackingScreen(
				viewModel: viewModel2
			)
			.task { viewModel2.state = .idle }
			
			TrackingScreen(
				viewModel: viewModel3
			)
			.task { viewModel3.state = .error("Error Message") }
		}
	}
}
