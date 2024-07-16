//
//  Created by João Pedro Fabiano Franco
//

import UIKit
import Combine
@testable import JData

public class FakeDataSource: DataSourceProtocol {
	let jsonFile: JSONFileProtocol

	init(jsonFile: JSONFileProtocol) {
		self.jsonFile = jsonFile
	}
	
	public func fetch<T>(request: Requestable) async throws -> T where T : Decodable {
		guard let data = get(file: self.jsonFile) else {
			throw RemoteDataSourceError.requestFailed
		}

		return try JSONDecoder().decode(T.self, from: data)
	}

	public func post(request: Requestable) async throws {}

	private func get(file: JSONFileProtocol) -> Data? {
		guard let url = Bundle.module.url(
			forResource: file.name,
			withExtension: "json"
		) else {
			return nil
		}

		do {
			let data = try Data(contentsOf: url)
			return data
		} catch {
			return nil
		}
	}
}


