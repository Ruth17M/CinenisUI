import Vapor
import Foundation

struct Seat : Codable, Identifiable{
    var row: String
    var column: Int
    var available: Bool
    var selected: Bool

    init(row: String, column: Int, available: Bool) {
        self.row = row
        self.column = column
        self.available = available
        self.selected = false
    }
}