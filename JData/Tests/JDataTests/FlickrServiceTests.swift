import XCTest
@testable import JData
import JFoundation

final class FlickrServiceTests: XCTestCase {
	func testRegularResponse() async throws {
		// given
		let service = FlickrService(dataSource: FakeDataSource(jsonFile: JSONFile.regular))
		
		// when
		let response = await service.getAnImage()
		
		// then
		XCTAssertEqual(
			response,
			.remote(
				URL(string: "https://live.staticflickr.com/65535/53767225458_0464c7b852_w.jpg")!
			)
		)
	}
	
	func testRegularMoreThanOneResponse() async throws {
		// given
		let service = FlickrService(dataSource: FakeDataSource(jsonFile: JSONFile.regularMoreThanOne))
		
		// when
		let response = await service.getAnImage()
		
		// then
		XCTAssertEqual(
			response,
			.remote(
				URL(string: "https://live.staticflickr.com/this/1_this_w.jpg")!
			)
		)
	}
	
	func testIrregularResponse() async throws {
		// given
		let service = FlickrService(dataSource: FakeDataSource(jsonFile: JSONFile.irregular))
		
		// when
		let response = await service.getAnImage()
		
		// then
		XCTAssertNil(response)
	}
	
	func testEmptyResponse() async throws {
		// given
		let service = FlickrService(dataSource: FakeDataSource(jsonFile: JSONFile.irregular))
		
		// when
		let response = await service.getAnImage()
		
		// then
		XCTAssertNil(response)
	}
}
