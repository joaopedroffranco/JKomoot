//
//  Created by Joao Pedro Franco on 15/07/24.
//

import SwiftUI

public struct JList<Data: Hashable, Row: View>: View {
	private var data: [Data]
	private var rowView: (Data) -> Row
	private let spacing: CGFloat
	
	public init(
		data: [Data],
		spacing: CGFloat = .zero,
		@ViewBuilder row: @escaping (Data) -> Row
	) {
		self.data = data
		self.rowView = row
		self.spacing = spacing
	}
	
	public var body: some View {
		List {
			ForEach(data, id: \.self) { object in
				rowView(object)
					.listRowSeparator(.hidden)
					.listRowInsets(
						.init(
							top: .zero,
							leading: .zero,
							bottom: spacing,
							trailing: .zero
						)
					)
					.listRowBackground(DesignSystem.Colors.background)
			}
		}
		.listStyle(.plain)
	}
}

struct JList_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			JList(data: ["a", "b", "c"]) { element in
				Text(element.description)
					.frame(height: 50)
					.frame(maxWidth: .infinity)
					.background(.red)
			}
			
			JList(data: [1, 2, 3, 4, 5], spacing: 10) { element in
				Text(element.description)
					.background(.red)
					.frame(height: 50)
					.frame(maxWidth: .infinity)
					.background(.red)
			}
			.previewInterfaceOrientation(.portraitUpsideDown)
		}
	}
}

