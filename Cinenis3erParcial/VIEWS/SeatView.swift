//
//  SeatView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 13/06/25.
//



import SwiftUI

struct SeatView: View {
    var seat: Seat

    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 30, height: 30)
            .foregroundColor(color(for: seat.status))
    }

    func color(for status: SeatStatus) -> Color {
        switch status {
        case .available:
            return .green
        case .selected:
            return .yellow
        case .occupied:
            return .red
        }
    }
}
