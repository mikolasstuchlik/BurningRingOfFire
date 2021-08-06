import SQLite

enum Tokens: TableBlueprint {

    static let id = Expression<Int64>("id")
    static let token = Expression<String>("token")

    static func creator(_ builder: TableBuilder) {
        builder.column(id, primaryKey: .autoincrement)
        builder.column(token)
    }
}