//
//  Seat.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 11/06/25.
//

import SwiftUI
enum SeatStatus {
    case available   // Verde
    case occupied    // Gris u oscuro
    case selected    // Amarillo u otro color
}


struct Seat: Identifiable {
    let id = UUID()
    let row: String
    let number: Int
    var status: SeatStatus

    var seatLabel: String {
        return "\(row)\(number)"
    }
}
