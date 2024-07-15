//
//  Created by Joao Pedro Franco on 12/07/24.
//

import Foundation
import JFoundation
import UIKit

class TrackingRouter: RouterProtocol {
	var parentRouter: RouterDelegate?
	let navigatioController: UINavigationController

	init(navigatioController: UINavigationController) {
		self.navigatioController = navigatioController
	}
	
	func start() {
		let viewController = makeTrackingViewController()
		navigatioController.pushViewController(viewController, animated: true)
	}
	
	func dismiss() {
		navigatioController.popViewController(animated: true)
		clean()
	}
	
	deinit {
		clean()
	}
}

private extension TrackingRouter {
	func makeTrackingViewController() -> UIViewController {
		let viewModel = TrackingViewModel()
		viewModel.router = self

		let viewController = TrackingViewController(viewModel: viewModel)
		return viewController
	}
}
