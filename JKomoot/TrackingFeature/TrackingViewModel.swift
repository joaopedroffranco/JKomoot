//
//  Created by Joao Pedro Franco on 12/07/24.
//

import Foundation
import Combine
import JFoundation
import JData

class TrackingViewModel: ObservableObject {
	var router: RouterDelegate?
	
	@Published var state: TrackingScreenState = .idle
	
	private let flickrService: FlickrServiceProtocol
	private let locationManager: LocationManagerProtocol
	private var cancellables: [AnyCancellable] = []
	
	init(
		flickrService: FlickrServiceProtocol = FlickrService(),
		locationManager: LocationManagerProtocol = LocationManager()
	) {
		self.flickrService = flickrService
		self.locationManager = locationManager
	}
	
	// MARK: Actions
	func onAppear() {
		setupLocationObservers()
	}

	@objc func stopTracking() {
		router?.dismiss()
	}
	
	deinit {
		locationManager.stopTracking()
	}
}

// MARK: Location
private extension TrackingViewModel {
	func setupLocationObservers() {
		locationManager.currentStatus
			.sink { [weak self] status in
				switch status {
				case .authorized:
					self?.state = .data([])
					self?.start()
				case .denied:
					self?.state = .error("Location has been denied.\n Please go to settings to allow location services.")
				case .requesting:
					self?.state = .error("Requesting location...")
				}
			}
			.store(in: &cancellables)
		
		locationManager.currentLocation
			.compactMap { $0 }
			.sink { [weak self] _ in self?.getFlickrImage() }
			.store(in: &cancellables)
	}
	
	func start() {
		locationManager.startTracking(within: 100)
	}
}

// MARK: Image
private extension TrackingViewModel {
	@objc func getFlickrImage() {
		Task {
			guard let image = await flickrService.getAnImage() else { return }
			switch state {
			case let .data(images):
				Task { @MainActor in state = .data([image] + images) }
			default:
				Task { @MainActor in state = .data([image]) }
			}
		}
	}
}
