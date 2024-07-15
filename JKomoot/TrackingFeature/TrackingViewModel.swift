//
//  TrackingViewModel.swift
//  JKomoot
//
//  Created by Joao Pedro Franco on 12/07/24.
//

import Foundation
import Combine
import JFoundation
import JData

class TrackingViewModel: ObservableObject {
	weak var router: TrackingRouterDelegate?
	
	@Published var trackingImages: [String] = []
	
	private var flickrService: FlickrServiceProtocol
	
	init(flickrService: FlickrServiceProtocol = FlickrService()) {
		self.flickrService = flickrService
	}
	
	func start() {
		Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getFlickrImage), userInfo: nil, repeats: true)
	}
	
	deinit {
		router?.dismiss()
	}
}

private extension TrackingViewModel {
	@objc func getFlickrImage() {
		Task {
			do {
				let image = try await flickrService.getImage()
				Task { @MainActor in trackingImages.append(image) }
			} catch {}
		}
	}
}
