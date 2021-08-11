public enum TokenKind: RawRepresentable {
    private static let apiTokenPrefix = "token-"

    case apiToken(_ account: String)

    public var rawValue: String {
        switch self {
        case let .apiToken(account):
            return TokenKind.apiTokenPrefix + account
        }
    }

    public init?(rawValue: String) {
        if rawValue.hasPrefix(TokenKind.apiTokenPrefix), rawValue.count > TokenKind.apiTokenPrefix.count {
            var modified = rawValue
            modified.removeFirst(TokenKind.apiTokenPrefix.count)
            self = .apiToken(modified)
            return
        }

        return nil
    }
}