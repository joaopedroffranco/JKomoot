//
//  Created by Joao Pedro Franco on 16/07/24.
//

import Foundation
import JData
import JFoundation

class FakeFlickrService: FlickrServiceProtocol {
	var anImage: ImageType?
	
	init(anImage: ImageType?) {
		self.anImage = anImage
	}
	
	func getAnImage() async -> ImageType? { anImage }
}
