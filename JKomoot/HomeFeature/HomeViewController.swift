//
//  ViewController.swift
//  JKomoot
//
//  Created by Joao Pedro Franco on 11/07/24.
//

import UIKit
import JUI
import JFoundation

class HomeViewController: UIViewController {
	weak var router: HomeRouterDelegate?
	
	private lazy var startButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Start Tracking", for: .normal)
		button.backgroundColor = DesignSystem.Colors.primary.uiColor
		button.tintColor = DesignSystem.Colors.secondary.uiColor
		button.titleLabel?.font = DesignSystem.Fonts.uiButton
		button.addTarget(
			self,
			action: #selector(startTrackingTap),
			for: .touchUpInside
		)
		button.layer.cornerRadius = DesignSystem.Radius.default
		return button
	}()
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nil, bundle: nil)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@objc
	private func startTrackingTap() {
		router?.didStartTracking()
	}
}

extension HomeViewController: ViewCodable {
	func buildViewHierarchy() {
		view.addSubview(startButton)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			view.centerXAnchor.constraint(equalTo: startButton.centerXAnchor),
			view.centerYAnchor.constraint(equalTo: startButton.centerYAnchor),

			startButton.widthAnchor.constraint(equalToConstant: 120),
			startButton.heightAnchor.constraint(equalToConstant: 60)
		])
	}
	
	func configureViews() {
		view.backgroundColor = DesignSystem.Colors.background.uiColor
		view.translatesAutoresizingMaskIntoConstraints = true
	}
}
