//
//  Created by Joao Pedro Franco on 15/07/24.
//

import SwiftUI
import JFoundation

public struct JImageCell: View {
	var image: ImageType
	
	public init(image: ImageType) {
		self.image = image
	}
	
	public var body: some View {
		CachedImage(image: image)
	}
}

struct JImageCell_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			JImageCell(image: .local("placeholder"))
				.frame(width: 300, height: 200)
				.previewLayout(.sizeThatFits)
			
			if let url = URL(string: "https://picsum.photos/200") {
				JImageCell(image: .remote(url))
					.frame(width: 300, height: 200)
					.previewLayout(.sizeThatFits)
			}
		}
	}
}