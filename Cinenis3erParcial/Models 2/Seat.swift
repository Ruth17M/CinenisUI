//
//  Seat.swift
//  Cinenis3erParcial
//
//  Created by ISSC_411_2024 on 16/06/25.
//

import Foundation
import SwiftUI
enum SeatStatus: String, Codable, CaseIterable, Identifiable { // Make it String RawRepresentable for easy string conversion
    case available
    case occupied
    case selected

    var id: String { self.rawValue } // Conformance to Identifiable for use in Picker, etc.
}

struct Seat : Codable, Identifiable {
    let id: String
    let row: String
    let column: Int
    var status: SeatStatus
    init(row: String, column: Int, initialStatus: SeatStatus = .available) {
        self.id = "\(row)\(column)"
        self.row = row
        self.column = column
        self.status = initialStatus
    }
}

