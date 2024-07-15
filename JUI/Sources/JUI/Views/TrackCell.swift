//
//  SwiftUIView.swift
//  
//
//  Created by Joao Pedro Franco on 15/07/24.
//

import SwiftUI

struct TrackCell: View {
	var image: ImageType
	
	var body: some View {
		switch image {
		case let .local(name):
			Image(name, bundle: .module)
				.resizable()
		case let .remote(url):
			AsyncImage(url: url) { image in
				image
			} placeholder: {
				Color.blue
			}
		}
	}
}

struct TrackCell_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			TrackCell(image: .local(name: "workers"))
				.frame(width: 300, height: 200)
				.previewLayout(.sizeThatFits)
			
			if let url = URL(string: "https://picsum.photos/200") {
				TrackCell(image: .remote(url: url))
					.frame(width: 300, height: 200)
					.previewLayout(.sizeThatFits)
			}
		}
	}
}
