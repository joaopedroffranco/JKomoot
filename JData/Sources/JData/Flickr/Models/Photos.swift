//
//  Created by Joao Pedro Franco on 16/07/24.
//

import Foundation

public struct Photo {
	public let id: String
	public let owner: String
	public let secret: String
	public let server: String
	public let title: String?
}

extension Photo: Decodable {}
