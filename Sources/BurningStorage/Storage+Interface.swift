import SQLite
import CryptoSwift
import BurningModels
import Foundation

public extension Storage {

    func getToken<T: RawRepresentable>(for identifier: T) throws -> Token? where T.RawValue == String {
        let iterator = try connection.prepare(table(for: Tokens.self).filter(Tokens.kind == identifier.rawValue)).makeIterator()
        return try iterator.next().flatMap { row -> Token? in 
            guard let data = Data.init(base64Encoded: row[Tokens.token])?.bytes else {
                throw Error.cyptographyFailed
            }
            let decrypted = try encryption.decrypt(data)

            return Token.init(accessToken: String(cString: decrypted))
        }
    }

    func deleteToken<T: RawRepresentable>(for identifier: T) throws  where T.RawValue == String {
        try connection.run(table(for: Tokens.self).filter(Tokens.kind == identifier.rawValue).delete())
    }

    func setToken<T: RawRepresentable>(_ newToken: Token, for identifier: T) throws where T.RawValue == String {
        try deleteToken(for: identifier)

        let cString = Array(newToken.accessToken.utf8CString).map { UInt8($0)}
        let encrypted = Data(try encryption.encrypt(cString)).base64EncodedString()
        _ = try connection.run(table(for: Tokens.self).insert(Tokens.kind <- identifier.rawValue, Tokens.token <- encrypted))
    }
}