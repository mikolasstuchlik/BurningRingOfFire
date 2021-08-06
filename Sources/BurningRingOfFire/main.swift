import Gtk
import BurningFioAPI
import BurningModels
import BurningStorage

let storage = try! Storage.init(password: "abcdefghabcdefgh")

try! storage.setToken(Token.init(accessToken: "abcdef"))
print(try! storage.getToken())