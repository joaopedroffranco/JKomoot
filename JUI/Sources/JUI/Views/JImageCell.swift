//
//  SwiftUIView.swift
//  
//
//  Created by Joao Pedro Franco on 15/07/24.
//

import SwiftUI

public struct JImageCell: View {
	var image: ImageType
	
	public init(image: ImageType) {
		self.image = image
	}
	
	public var body: some View {
		switch image {
		case let .local(name):
			Image(name, bundle: .module)
				.resizable()
		case let .remote(url):
			AsyncImage(url: url) { image in
				image
			} placeholder: {
				DesignSystem.Colors.background
			}
		}
	}
}

struct JImageCell_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			JImageCell(image: .local(name: "workers"))
				.frame(width: 300, height: 200)
				.previewLayout(.sizeThatFits)
			
			if let url = URL(string: "https://picsum.photos/200") {
				JImageCell(image: .remote(url: url))
					.frame(width: 300, height: 200)
					.previewLayout(.sizeThatFits)
			}
		}
	}
}
