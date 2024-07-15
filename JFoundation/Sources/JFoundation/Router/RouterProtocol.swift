//
//  Created by João Pedro Fabiano Franco on 18.11.23.
//

import UIKit

public protocol RouterProtocol: RouterDelegate {
  var parentRouter: RouterDelegate? { get set }

  func start()
}

public extension RouterProtocol {
  func clean() {
    parentRouter = nil
  }
}
