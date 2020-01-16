import XCTest
@testable import Netswift

final class NetswiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Netswift().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
