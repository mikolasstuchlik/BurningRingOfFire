import SQLite
import Foundation
import CryptoSwift

private func randomString(length: Int) -> String {
    let base = (33...126).map { Character(UnicodeScalar($0))}
    let selection = (0..<length).map { _ in base.randomElement()! }
    return selection.reduce(into: "") { result, character in
        result += String(character)
    }
}

public final class Storage {
    public enum Error: Swift.Error {
        case applicationFailedToLocateHome
        case unregisteredTable
        case cyptographyFailed
    }

    let connection: Connection 
    let registered: [TableBlueprint.Type]
    let encryption: AES

    static let defaultDirectoryName = "BurningRingOfFire"
    static let defaultDatabaseName = "burningStorage.sqlite3"
    static let keyLength = 32
    static let assumedBlockSize = 16

    public init(file path: String? = nil, password: String) throws {
        self.connection = try Connection(path ?? (try Storage.initializeDefaultStorage()))
        self.registered = Storage.allTables
        var hasher = SHA3(variant: .sha512)
        let hashed = Data(try hasher.finish(withBytes: password.bytes))

        let iv = Array(randomString(length: Storage.assumedBlockSize).bytes.prefix(Storage.assumedBlockSize))
        let key = Array(hashed.prefix(Storage.keyLength))
        self.encryption = try AES(key: key, blockMode: CBC(iv: iv))

        try initialize()
    }

    private static func initializeDefaultStorage() throws -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)

        guard let home = paths.first else {
            throw Error.applicationFailedToLocateHome
        }

        if !FileManager.default.fileExists(atPath: home + "/" + defaultDirectoryName) {

            try FileManager.default.createDirectory(atPath: home + "/" + defaultDirectoryName, withIntermediateDirectories: false)
        }

        return home + "/" + defaultDirectoryName + "/" + defaultDatabaseName
    }

    private func initialize() throws {
        for blueprint in registered {
            do {
                _ = try connection.scalar(blueprint.table.exists)
            } catch {
                try connection.run(blueprint.create()) 
            }
        }
    }

    func table<T: TableBlueprint>(for blueprint: T.Type) -> Table {
        guard registered.contains(where: { $0 == T.self}) else {
            fatalError("\(Error.unregisteredTable)")
        }

        return T.table
    }

}