//
//  ViewController.swift
//  JKomoot
//
//  Created by Joao Pedro Franco on 11/07/24.
//

import UIKit
import JFoundation

class HomeViewController: UIViewController {
	weak var router: HomeRouterDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .blue
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(tap))
		view.addGestureRecognizer(gesture)
	}
	
	@objc
	private func tap() {
		router?.didStartTracking()
	}
}
