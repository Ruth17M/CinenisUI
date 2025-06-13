//
//  SeatGridView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 13/06/25.
//

import SwiftUI

struct SeatGridView: View {
    let rows = Array("ABCDEFGH")
    let columns = 1...12
    @State private var seats: [[Seat]] = []
    @State private var selectedSeatsCount: Int = 3

    var body: some View {
        VStack(spacing: 10) {
            Text("PANTALLA")
                .font(.headline)

            // Encabezado con números de columna
            HStack {
                Text(" ") // espacio en blanco para alineación
                    .frame(width: 30)

                ForEach(columns, id: \.self) { number in
                    Text("\(number)")
                        .frame(width: 30, height: 20)
                        .font(.caption)
                }
            }

            // Asientos con letras a la izquierda
            ForEach(0..<rows.count, id: \.self) { rowIndex in
                HStack(spacing: 0) {
                    // Letra de la fila
                    Text(String(rows[rowIndex]))
                        .frame(width: 30)
                        .font(.caption)

                    // Asientos de esa fila
                    ForEach(0..<columns.count, id: \.self) { columnIndex in
                        if rowIndex < seats.count && columnIndex < seats[rowIndex].count {
                            let seat = seats[rowIndex][columnIndex]
                            SeatView(seat: seat)
                        } else {
                            // asiento invisible
                            Rectangle()
                                .frame(width: 30, height: 30)
                                .opacity(0)
                        }
                    }
                }
            }

            Spacer()
        }
        .padding()
        .onAppear {
            generateSeats()
        }
    }

    func generateSeats() {
        var allSeats: [[Seat]] = []

        for row in rows {
            var rowSeats: [Seat] = []
            for col in columns {
                rowSeats.append(Seat(row: String(row), number: col, status: .available))
            }
            allSeats.append(rowSeats)
        }

        // Aplanar, modificar estados, y rearmar
        var flatSeats = allSeats.flatMap { $0 }

        flatSeats.shuffle()

        for i in 0..<15 {
            flatSeats[i].status = .occupied
        }

        var selected = 0
        for i in 15..<flatSeats.count {
            if selected < selectedSeatsCount && flatSeats[i].status == .available {
                flatSeats[i].status = .selected
                selected += 1
            }
        }

        // Convertir de nuevo en matriz
        var reshaped: [[Seat]] = []
        var index = 0
        for _ in rows {
            var row: [Seat] = []
            for _ in columns {
                row.append(flatSeats[index])
                index += 1
            }
            reshaped.append(row)
        }

        self.seats = reshaped
    }
}
