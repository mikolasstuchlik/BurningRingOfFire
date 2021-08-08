public struct Column<T: Codable>: Codable {
    public let value: T
    public let name: String
    public let id: Int
}

public struct Transaction: Codable {

    private enum CodingKeys: String, CodingKey {
    case transactionId = "column22"
    case date = "column0"
    case amount = "column1"
    case currency = "column14"
    case secondAccount = "column2"
    case secondAccountName = "column10"
    case secondAccountBank = "column3"
    case secondAccountBankName = "column12"
    case constantSymbol = "column4"
    case variableSymbol = "column5"
    case specificSymbol = "column6"
    case userInfo = "column7"
    case message = "column16"
    case transactionType = "column8"
    case authorizedBy = "column9"
    case additionalInformation = "column18"
    case commentary = "column25"
    case bicId = "column26"
    case orderNumber = "column17"
    case reference = "column27"
    }

// Column22 ID pohybu unikátní číslo pohybu - 10 numerických znaků
    public let transactionId: Column<UInt64>
// Column0 Datum datum pohybu ve tvaru rrrr-mm-dd+GMT
    // TODO: Date
    public let date: Column<String>
// Column1 Objem velikost přijaté (odeslané) částky
    public let amount: Column<Double>
// Column14 Měna měna přijaté (odeslané) částky dle standardu ISO 4217
    public let currency: Column<String>
// Column2 Protiúčet číslo protiúčtu
    public let secondAccount: Column<String>?
// Column10 Název protiúčtu název protiúčtu
    public let secondAccountName: Column<String>?
// Column3 Kód banky číslo banky protiúčtu
    public let secondAccountBank: Column<String>?
// Column12 Název banky název banky protiúčtu
    public let secondAccountBankName: Column<String>?
// Column4 KS konstantní symbol
    public let constantSymbol: Column<String>?
// Column5 VS variabilní symbol
    public let variableSymbol: Column<String>?
// Column6 SS specifický symbol
    public let specificSymbol: Column<String>?
// Column7 Uživatelská identifikace uživatelská identifikace
    public let userInfo: Column<String>?
// Column16 Zpráva pro příjemce zpráva pro příjemce
    public let message: Column<String>?
// Column8 Typ pohybu typ operace
    // TODO: Typ enum
    public let transactionType: Column<String>
// Column9 Provedl oprávněná osoba, která zadala příkaz
    public let authorizedBy: Column<String>?
// Column18 Upřesnění upřesňující informace
    public let additionalInformation: Column<String>?
// Column25 Komentář komentář
    public let commentary: Column<String>?
// Column26 BIC bankovní identifikační kód banky protiúčtu dle standardu ISO 9362
    public let bicId: Column<String>?
// Column17 ID pokynu číslo příkazu
    public let orderNumber: Column<UInt64>
// Column27 Reference plátce bližší identifikace platby dle ujednání mezi účastníky platby
    public let reference: Column<String>?

}