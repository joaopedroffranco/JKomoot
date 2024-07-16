//
//  Created by Joao Pedro Franco on 11/07/24.
//

import XCTest
import JFoundation
import Combine
@testable import JKomoot
import CoreLocation

class TrackingViewModelTests: XCTestCase {
	private var cancellable: AnyCancellable?
	
	// MARK: OnAppear
	func testOnAppearRequestingLocation() throws {
		// given
		let locationManager = FakeLocationManager()
		let viewModel = TrackingViewModel(
			flickrService: FakeFlickrService(anImage: aRemoteImage()),
			locationManager: locationManager
		)
		
		// when
		viewModel.onAppear()
		
		// then
		XCTAssertEqual(viewModel.state, .error("Requesting location..."))
	}
	
	func testOnAppearLocationDenied() throws {
		// given
		let locationManager = FakeLocationManager(currentStatus: .denied)
		let viewModel = TrackingViewModel(
			flickrService: FakeFlickrService(anImage: aRemoteImage()),
			locationManager: locationManager
		)
		
		// when
		viewModel.onAppear()
		
		// then
		XCTAssertEqual(viewModel.state, .error("Location has been denied.\n Please go to settings to allow location services."))
	}
	
	func testOnAppearLocationAuthorized() throws {
		// given
		let locationManager = FakeLocationManager(currentStatus: .authorized)
		let viewModel = TrackingViewModel(
			flickrService: FakeFlickrService(anImage: aRemoteImage()),
			locationManager: locationManager
		)
		
		// when
		viewModel.onAppear()
		
		// then
		XCTAssertEqual(viewModel.state, .data([]))
		XCTAssertEqual(locationManager.didStartTrackingWithin, 100)
	}
	
	// MARK: Access Location Updates
	func testLocationStatusDidUpdateToDenied() throws {
		// given
		let locationManager = FakeLocationManager(currentStatus: .authorized)
		let viewModel = TrackingViewModel(
			flickrService: FakeFlickrService(anImage: aRemoteImage()),
			locationManager: locationManager
		)
		
		// when
		viewModel.onAppear()
		locationManager.currentStatus.send(.denied)
		
		// then
		XCTAssertEqual(viewModel.state, .error("Location has been denied.\n Please go to settings to allow location services."))
		XCTAssertTrue(locationManager.didStopTracking)
	}
	
	func testLocationStatusDidUpdateToAuthorized() throws {
		// given
		let locationManager = FakeLocationManager(currentStatus: .denied)
		let viewModel = TrackingViewModel(
			flickrService: FakeFlickrService(anImage: aRemoteImage()),
			locationManager: locationManager
		)
		
		// when
		viewModel.onAppear()
		locationManager.currentStatus.send(.authorized)
		
		// then
		XCTAssertEqual(viewModel.state, .data([]))
		XCTAssertEqual(locationManager.didStartTrackingWithin, 100)
	}
	
	// MARK: Current Location Updates
	func testLocationDidUpdateFirstTime() throws {
		// given
		let locationManager = FakeLocationManager(currentStatus: .authorized)
		let viewModel = TrackingViewModel(
			flickrService: FakeFlickrService(anImage: aRemoteImage()),
			locationManager: locationManager
		)
		
		// when
		viewModel.onAppear()
		locationManager.currentLocation.send(anLocation)
		
		// then
		let expectation = XCTestExpectation()
		var expectedState: TrackingScreenState?
		cancellable = viewModel.$state
			.dropFirst()
			.sink {
				expectedState = $0
				expectation.fulfill()
			}
		
		wait(for: [expectation], timeout: 2)
		XCTAssertEqual(expectedState, .data([aRemoteImage()]))
	}
	
	func testLocationDidUpdateLater() throws {
		// given
		let locationManager = FakeLocationManager(currentStatus: .authorized)
		let viewModel = TrackingViewModel(
			flickrService: FakeFlickrService(anImage: aRemoteImage(3)),
			locationManager: locationManager
		)
		
		// when
		viewModel.onAppear()
		viewModel.state = .data([aRemoteImage(2), aRemoteImage(1)])
		locationManager.currentLocation.send(anLocation)
		
		// then
		let expectation = XCTestExpectation()
		var expectedState: TrackingScreenState?
		cancellable = viewModel.$state
			.dropFirst()
			.sink {
				expectedState = $0
				expectation.fulfill()
			}
		
		wait(for: [expectation], timeout: 2)
		XCTAssertEqual(expectedState, .data([aRemoteImage(3), aRemoteImage(2), aRemoteImage(1)]))
	}
}

private extension TrackingViewModelTests {
	func aRemoteImage(_ id: Int = 1) -> ImageType {
		.remote(URL(string: id.description)!)
	}
	
	var anLocation: CLLocation? {
		CLLocation(latitude: 10, longitude: 10)
	}
}
