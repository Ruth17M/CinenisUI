//
//  SeatSelectorView.swift
//  Cinenis3erParcial
//
//  Created by ISSC_411_2024 on 18/06/25.
//

import SwiftUI

struct SeatSelectorView: View {
    @Binding var seatCount: Int
    let minSeats = 1
    let maxSeats = 10

    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                if seatCount > minSeats {
                    seatCount -= 1
                }
            }) {
                Image(systemName: "minus.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(seatCount > minSeats ? Color("ColorAmarillo") : .gray)
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(seatCount == minSeats)

            Text("\(seatCount)")
                .font(.title)
                .frame(minWidth: 50)

            Button(action: {
                if seatCount < maxSeats {
                    seatCount += 1
                }
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(seatCount < maxSeats ? Color("ColorAmarillo") : .gray)
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(seatCount == maxSeats)
        }
    }
}
