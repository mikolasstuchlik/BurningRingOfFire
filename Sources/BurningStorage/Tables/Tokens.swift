import SQLite

enum Tokens: TableBlueprint {

    static let kind = Expression<String>("kind")
    static let token = Expression<String>("token")

    static func creator(_ builder: TableBuilder) {
        builder.column(kind, primaryKey: true)
        builder.column(token)
    }
}