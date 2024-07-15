//
//  Created by Joao Pedro Franco on 12/07/24.
//

import UIKit
import SwiftUI
import JUI

class TrackingViewController: UIHostingController<TrackingScreen> {
	let viewModel: TrackingViewModel
	
	init(viewModel: TrackingViewModel) {
		self.viewModel = viewModel
		let screen = TrackingScreen(viewModel: viewModel)
		super.init(rootView: screen)
		
		configureNavigationBar()
		view.backgroundColor = DesignSystem.Colors.background.uiColor
	}
	
	@MainActor required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc private func stop() {
		viewModel.stopTracking()
	}
	
	private func configureNavigationBar() {
		navigationItem.title = "Tracking"
		navigationItem.setHidesBackButton(true, animated: false)
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			title: "Stop",
			style: .plain,
			target: self,
			action: #selector(stop)
		)
	}
}
