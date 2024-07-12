//
//  HomeRouter.swift
//  JKomoot
//
//  Created by Joao Pedro Franco on 12/07/24.
//

import Foundation
import JFoundation
import UIKit

class HomeRouter: RouterProtocol {
	var parentRouter: RouterProtocol?
	var nextRouter: RouterProtocol?
	
	let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let viewController = HomeViewController()
		viewController.router = self
		navigationController.setViewControllers([viewController], animated: false)
	}
	
	func dismiss() {
		navigationController.setViewControllers([], animated: false)
	}
}

extension HomeRouter: HomeRouterDelegate {
	func didStartTracking() {
		nextRouter = TrackingRouter(
			navigatioController: navigationController,
			parentRouter: self
		)
		nextRouter?.start()
	}
}
