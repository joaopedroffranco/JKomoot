//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import JUI
import JFoundation

class MainRouter: RouterProtocol {
  weak var parentRouter: RouterDelegate?
  let navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
		let backgroundColor = DesignSystem.Colors.background.uiColor
		self.navigationController.navigationBar.backgroundColor = backgroundColor
		self.navigationController.navigationBar.barTintColor = backgroundColor
		self.navigationController.navigationBar.shadowImage = UIImage()
		self.navigationController.navigationBar.titleTextAttributes = [
			NSAttributedString.Key.foregroundColor: DesignSystem.Colors.dark.uiColor
		]
  }

  func start() {
    let homeRouter = HomeRouter(navigationController: navigationController)
		homeRouter.parentRouter = self
		homeRouter.start()
  }

  func dismiss() {}
}
