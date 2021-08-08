@testable import BurningModels
@testable import BurningStorage
import XCTest

final class StorageTests: XCTestCase {
    enum TokenKind: String { case testing }

    let storagePath = NSTemporaryDirectory() + "/" + "RingOfFireDbTest.sqlite3"
    lazy var storage = try! Storage(file: self.storagePath, password: "AhojMiki")

    deinit {
        try! FileManager.default.removeItem(atPath: storagePath)
    }

    func testTokenStorage() {
        try! storage.setToken(Token.init(accessToken: "abcdef"), for: TokenKind.testing)
        print(try! storage.getToken(for: TokenKind.testing))
    }

    static var allTests = [
        ("testTokenStorage", testTokenStorage),
    ]
}
