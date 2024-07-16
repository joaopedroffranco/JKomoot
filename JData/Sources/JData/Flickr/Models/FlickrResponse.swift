//
//  Created by Joao Pedro Franco on 16/07/24.
//

import Foundation
import JFoundation

public struct FlickrResponse {
	public let photos: [Photo]
	public var firstImage: ImageType? { image }
}

extension FlickrResponse: Decodable {
	enum CodingKeys: String, CodingKey {
		case response = "photos"
		case photos = "photo"
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		let response = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
		self.photos = try response.decode([Photo].self, forKey: .photos)
	}
}

private extension FlickrResponse {
	var image: ImageType? {
		guard
			let photo = photos.first,
			let url = URL(string: "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_w.jpg")
		else { return nil }
		
		return .remote(url)
	}
}
