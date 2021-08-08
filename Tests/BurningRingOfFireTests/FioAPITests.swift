@testable import BurningModels
@testable import BurningFioAPI
import XCTest

final class FioAPITests: XCTestCase {

    func testResponseJSON() {
        let path = "/home/mikolas/Developer/scripts/transactions.json"
        let data = try! Data.init(contentsOf: URL.init(fileURLWithPath: path))
        let decoder = JSONDecoder()
        let decoded = try! decoder.decode(TransactionResponse.self, from: data)

        let types = decoded.accountStatement.transactionList.transaction.map { $0.transactionType.value }
        print(Set(types))
    }

    static var allTests = [
        ("testResponseJSON", testResponseJSON),
    ]
}
