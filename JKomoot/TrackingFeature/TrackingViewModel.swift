//
//  TrackingViewModel.swift
//  JKomoot
//
//  Created by Joao Pedro Franco on 12/07/24.
//

import Foundation
import Combine
import JFoundation

class TrackingViewModel: ObservableObject {
	weak var router: TrackingRouterDelegate?
	
	deinit {
		router?.dismiss()
	}
}
