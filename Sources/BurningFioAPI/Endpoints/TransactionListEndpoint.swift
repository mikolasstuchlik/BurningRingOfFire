import Foundation
import FTAPIKit

public struct TansactionListEndpoint: ResponseEndpoint, Authorized {
    public typealias Response = TransactionResponse

    public var path: String { "/periods/\(tokenPlaceholder)/\(TansactionListEndpoint.formatter.string(from: from))/\(TansactionListEndpoint.formatter.string(from: to))/transactions.json" }

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    public let from: Date
    public let to: Date 

    public init(from: Date, to: Date) {
        self.from = from
        self.to = to
    }
}