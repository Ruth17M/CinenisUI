//
//  asientosprueba.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 14/06/25.
//

import SwiftUI

struct Seat: Identifiable, Hashable {
    let id = UUID()
    let row: String
    let column: Int
    var isOccupied: Bool
    var isSelected: Bool
}

struct SeatsGridView: View {
    let rows = Array("ABCDEFGHI")
    let columns = 1...12
    
    @State private var seats: [[Seat]] = []
    
    var body: some View {
        VStack(spacing: 16) {
            Text("PANTALLA")
                .font(.headline)
                .padding(.top, 10)
            
            LazyVStack(spacing: 10) {
                ForEach(0..<rows.count, id: \.self) { rowIndex in
                    HStack(spacing: 12) {
                        Text(rows[rowIndex])
                            .frame(width: 20)
                        ForEach(0..<columns.count, id: \.self) { colIndex in
                            let seat = seats[rowIndex][colIndex]
                            SeatIconView(seat: seat)
                                .onTapGesture {
                                    if !seat.isOccupied {
                                        seats[rowIndex][colIndex].isSelected.toggle()
                                    }
                                }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            generateSeats()
        }
    }
    
    func generateSeats() {
        var allSeats: [Seat] = []
        for row in rows {
            for col in columns {
                allSeats.append(Seat(row: String(row), column: col, isOccupied: false, isSelected: false))
            }
        }
        
        var occupiedIndexes = Set<Int>()
        while occupiedIndexes.count < 15 {
            let random = Int.random(in: 0..<allSeats.count)
            if !occupiedIndexes.contains(random) {
                occupiedIndexes.insert(random)
            }
        }
        
        for index in occupiedIndexes {
            allSeats[index].isOccupied = true
        }
        
        seats = stride(from: 0, to: allSeats.count, by: columns.count).map {
            Array(allSeats[$0..<min($0 + columns.count, allSeats.count)])
        }
    }
}

struct SeatIconView: View {
    let seat: Seat

    var body: some View {
        Image(systemName: "carseat.left.fill")
            .font(.system(size: 20))
            .foregroundColor(colorForSeat())
    }

    func colorForSeat() -> Color {
        if seat.isOccupied {
            return .red
        } else if seat.isSelected {
            return .yellow
        } else {
            return .gray
        }
    }
}

struct SeatsGridView_Previews: PreviewProvider {
    static var previews: some View {
        SeatsGridView()
            .preferredColorScheme(.dark)
    }
}
