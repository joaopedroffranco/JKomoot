//
//  TrackingViewController.swift
//  JKomoot
//
//  Created by Joao Pedro Franco on 12/07/24.
//

import UIKit
import SwiftUI
import JUI

class TrackingViewController: UIHostingController<TrackingScreen> {
	init(viewModel: TrackingViewModel) {
		let screen = TrackingScreen(viewModel: viewModel)
		super.init(rootView: screen)
		navigationItem.title = "Tracking"
		view.backgroundColor = DesignSystem.Colors.background.uiColor
	}
	
	@MainActor required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
