//
//  Created by Joao Pedro Franco on 11/07/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	var mainRouter: MainRouter?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		startApp()

		return true
	}
	
	private func startApp() {
		let navigationController = UINavigationController()
		
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		window?.overrideUserInterfaceStyle = .light

		mainRouter = MainRouter(navigationController: navigationController)
		mainRouter?.start()
	}
}
