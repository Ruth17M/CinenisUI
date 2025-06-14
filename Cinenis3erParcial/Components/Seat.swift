//
//  Seat.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 11/06/25.
//

import SwiftUI


struct Seat: Identifiable {
    let id = UUID()
    let row: String
    let number: Int
    var status: SeatStatus

    var seatLabel: String {
        return "\(row)\(number)"
    }
}

enum SeatStatus {
    case available
    case selected
    case occupied
}
