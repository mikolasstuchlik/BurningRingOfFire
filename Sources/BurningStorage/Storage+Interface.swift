import SQLite
import CryptoSwift
import BurningModels
import Foundation

public extension Storage {

    func getToken() throws -> Token? {
        let iterator = try connection.prepare(table(for: Tokens.self)).makeIterator()
        return try iterator.next().flatMap { row -> Token? in 
            guard let data = Data.init(base64Encoded: row[Tokens.token])?.bytes else {
                throw Error.cyptographyFailed
            }
            let decrypted = try encryption.decrypt(data)

            return Token.init(accessToken: String(cString: decrypted))
        }
    }

    func deleteToken() throws {
        try connection.run(table(for: Tokens.self).delete())
    }

    func setToken(_ newToken: Token) throws {
        try deleteToken()

        let cString = Array(newToken.accessToken.utf8CString).map { UInt8($0)}
        let encrypted = Data(try encryption.encrypt(cString)).base64EncodedString()
        _ = try connection.run(table(for: Tokens.self).insert(Tokens.token <- encrypted))
    }

}