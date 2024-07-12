//
//  Created by João Pedro Fabiano Franco
//

import Combine
import CoreLocation

public protocol LocationProtocol {
  var currentStatus: LocationAuthorizationStatus { get }
}

public class LocationManager: NSObject, LocationProtocol {
  var nativeLocationManager: CLLocationManager

  public var currentStatus: LocationAuthorizationStatus

  public init(nativeLocationManager: CLLocationManager = CLLocationManager()) {
    self.nativeLocationManager = nativeLocationManager
    self.currentStatus = LocationAuthorizationStatus(from: self.nativeLocationManager.authorizationStatus)
    super.init()
    self.nativeLocationManager.delegate = self
    requestAuthorizationIfNeeded()
  }

  private func requestAuthorizationIfNeeded() {
    nativeLocationManager.requestWhenInUseAuthorization()
  }
}

extension LocationManager: CLLocationManagerDelegate {
  public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    let newStatus = LocationAuthorizationStatus(from: manager.authorizationStatus)

    if newStatus != currentStatus {
      currentStatus = newStatus
    }
  }
}
