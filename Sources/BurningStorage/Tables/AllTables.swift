import SQLite

extension Storage {
    static let allTables: [TableBlueprint.Type] = [
        Tokens.self
    ]
}

protocol TableBlueprint {
    static var table: Table { get }

    static func creator(_ builder: TableBuilder)
}

extension TableBlueprint {
    static var table: Table { Table(String(describing: Self.self))}
    
    static func create() -> String {
        table.create(block: creator(_:))
    }
}
