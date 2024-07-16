//
//  Created by Joao Pedro Franco on 16/07/24.
//

import Foundation

public protocol JSONFileProtocol {
	var name: String { get }
}

public enum JSONFile: JSONFileProtocol {
	case regular
	case regularMoreThanOne
	case irregular
	case empty

	public var name: String {
		switch self {
		case .regular: return "regular"
		case .regularMoreThanOne: return "regular_more_than_one"
		case .irregular: return "irregular"
		case .empty: return "empty"
		}
	}
}
