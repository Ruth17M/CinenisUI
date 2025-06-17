import Vapor
import Foundation
import SwiftUI
struct Seat : Codable, Identifiable{
    var row: String
    var column: Int
    var available: Bool
    var selected: Bool

    enum SeatStatus {
        case available   // Verde
        case occupied    // Gris u oscuro
        case selected    // Amarillo u otro color
    }

    init(row: String, column: Int, available: Bool) {
        self.row = row
        self.column = column
        self.available = available
        self.selected = false
    }
}

