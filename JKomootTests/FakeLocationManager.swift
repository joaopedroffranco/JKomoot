//
//  Created by Joao Pedro Franco on 16/07/24.
//

import Combine
import CoreLocation
import Foundation
import JFoundation

class FakeLocationManager: LocationManagerProtocol {
	var currentStatus: CurrentValueSubject<LocationAuthorizationStatus, Never>
	var currentLocation: CurrentValueSubject<CLLocation?, Never>
	
	var didStartTrackingWithin: Double?
	var didStopTracking = false
	
	init(
		currentStatus: LocationAuthorizationStatus = .requesting,
		currentLocation: CLLocation? = nil
	) {
		self.currentStatus = .init(currentStatus)
		self.currentLocation = .init(currentLocation)
	}
	
	func startTracking(within: Double) {
		didStartTrackingWithin = within
	}
	
	func stopTracking() {
		didStopTracking = true
	}
}
