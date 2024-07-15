//
//  Created by Joao Pedro Franco on 15/07/24.
//

import Foundation
import JFoundation

public protocol FlickrServiceProtocol {
	func getAnImage() async -> ImageType?
}

public class FlickrService: FlickrServiceProtocol {
	var dataSource: RemoteDataSource
	
	public init(dataSource: RemoteDataSource = RemoteDataSource()) {
		self.dataSource = dataSource
	}
	
	public func getAnImage() async -> ImageType? {
		guard let response: FlickrResponse = try? await dataSource.fetch(request: FlickrRequest.searchRandomImage) else { return nil }
		return response.firstImage
	}
}
