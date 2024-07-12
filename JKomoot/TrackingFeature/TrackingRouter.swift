//
//  TrackingRouter.swift
//  JKomoot
//
//  Created by Joao Pedro Franco on 12/07/24.
//

import Foundation
import JFoundation
import UIKit

class TrackingRouter: RouterProtocol {
	var parentRouter: RouterProtocol?
	var nextRouter: RouterProtocol?
	
	let navigatioController: UINavigationController
	
	init(
		navigatioController: UINavigationController,
		parentRouter: RouterProtocol
	) {
		self.navigatioController = navigatioController
		self.parentRouter = parentRouter
	}
	
	func start() {
		let viewController = makeTrackingViewController()
		navigatioController.pushViewController(viewController, animated: true)
	}
	
	func dismiss() {
		clean()
	}
	
	deinit {
		clean()
	}
}

extension TrackingRouter: TrackingRouterDelegate {}

private extension TrackingRouter {
	func makeTrackingViewController() -> UIViewController {
		let viewModel = TrackingViewModel()
		viewModel.router = self

		let viewController = TrackingViewController(viewModel: viewModel)

		return viewController
	}
}
