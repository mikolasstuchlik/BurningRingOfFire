import Foundation

public struct AccountInfo: Codable {
    public let idList: UInt64?
    public let idFrom: UInt64
    public let closingBalance: Double
    public let iban: String
    public let accountId: String
    public let bankId: String
    public let idLastDownload: UInt64?
    // TODO: Date
    public let dateStart: String
    public let idTo: UInt64
    public let bic: String
    public let yearList: UInt64?
    public let currency: String
    // TODO: Date
    public let dateEnd: String
    public let openingBalance: Double
}