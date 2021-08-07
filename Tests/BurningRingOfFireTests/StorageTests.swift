@testable import BurningModels
@testable import BurningStorage
import XCTest

final class StorageTests: XCTestCase {
    let storagePath = NSTemporaryDirectory() + "/" + "RingOfFireDbTest.sqlite3"
    let storage = try! Storage(path: storagePath, password: "AhojMiki")

    func testTokenStorage() {
        try! storage.setToken(Token.init(accessToken: "abcdef"))
        print(try! storage.getToken())
    }

    static var allTests = [
        ("testTokenStorage", testTokenStorage),
    ]
}
