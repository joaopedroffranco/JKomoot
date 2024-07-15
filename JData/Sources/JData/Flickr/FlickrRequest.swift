//
//  Created by Joao Pedro Franco on 16/07/24.
//

import Foundation

enum FlickrRequest: Requestable {
	case searchRandomImage

	var method: RequestMethod { .get }
	
	var host: String { "https://www.flickr.com/services/rest/" }
	
	var endpoint: String { "" }
	
	var params: [String : String]? {
		var params = [
			"api_key": "6f9424688b8b04ce59f8043cdb930995",
			"format": "json",
			"nojsoncallback": "1"
		]
		
		switch self {
		case .searchRandomImage:
			params["method"] = "flickr.photos.search"
			params["per_page"] = "1"
			params["tags"] = "trekking"
			params["page"] = Int.random(in: 1...4000).description // Makes it random
		}

		return params
	}
	
	var headers: [String : String]? { nil }
	
	var cachePolicy: URLRequest.CachePolicy { .reloadIgnoringLocalCacheData }
}
