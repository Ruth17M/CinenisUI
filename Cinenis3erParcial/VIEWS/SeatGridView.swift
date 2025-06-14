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
           
            
            //Asientos muestra
            HStack(spacing: 40) {
                
                //seleccionado
                VStack(spacing: 8) {
                    Image(systemName: "carseat.left.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.yellow)
                    Text("Seleccionado")
                        .foregroundColor(.white)
                        .font(.caption)
                }
                
                // Asiento ocupado
                VStack(spacing: 8) {
                    Image(systemName: "carseat.left.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                    Text("Ocupado")
                        .foregroundColor(.white)
                        .font(.caption)
                }
                
                // Asiento seleccionado
                VStack(spacing: 8) {
                    Image(systemName: "carseat.left.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.green)
                    Text("Libre")
                        .foregroundColor(.white)
                        .font(.caption)
                }
            }
            .padding()

            //Linea curva de pantalla
            GeometryReader { geometry in
                      Path { path in
                          let width = geometry.size.width
                          let height: CGFloat = 20

                          path.move(to: CGPoint(x: 0, y: height))
                          path.addQuadCurve(
                              to: CGPoint(x: width, y: height),
                              control: CGPoint(x: width / 2, y: 0)
                          )
                      }
                      .stroke(Color.white, lineWidth: 4)
                  }
                  .frame(height: 25)
            Text("PANTALLA")
                .foregroundColor(.white)
                .font(.title)
                .padding(.horizontal)
             

            
            //números de columna
            HStack(spacing: 10)  {
                Text(" ") // espacio en blanco para alineación
                    .frame(width: 30)

                ForEach(columns, id: \.self) { number in
                    Text("\(number)")
                        .frame(width: 30, height: 20)
                        .font(.caption)
                        .foregroundColor(.white)
                        
                }
            }

            //letras de asientos
            ForEach(0..<rows.count, id: \.self) { rowIndex in
                HStack(spacing: 0) {
                    // Letra de la fila
                    Text(String(rows[rowIndex]))
                        .frame(width: 30)
                        .font(.caption)
                        .foregroundColor(.white)

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

        // Aplanar la matriz
        var flatSeats = allSeats.flatMap { $0 }

        // Escoge 15 posiciones únicas para los asientos ocupados
        var occupiedIndices = Set<Int>()
        while occupiedIndices.count < 15 {
            occupiedIndices.insert(Int.random(in: 0..<flatSeats.count))
        }

        for index in occupiedIndices {
            flatSeats[index].status = .occupied
        }

        // Marcar asientos seleccionados
        var selected = 0
        for i in 0..<flatSeats.count {
            if selected < selectedSeatsCount && flatSeats[i].status == .available {
                flatSeats[i].status = .selected
                selected += 1
            }
        }

        // Reconstruir matriz
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
