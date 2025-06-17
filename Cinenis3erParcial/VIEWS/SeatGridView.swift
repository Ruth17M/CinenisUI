//
//  SeatGridView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 13/06/25.
//

import SwiftUI

struct SeatGridView: View {
    let function : Function
    @Binding var numeroAsientos : Int
    @Binding var asientosSeleccionados : [Seat]
    let rows = Array("ABCDEFGH")
    let columns = 1...12
    var a : Int = 0
    var b : Int = 0
    @State private var seats: [[Seat]] = [[]]
    @State private var selectedSeatsCount: Int = 3
    @State var rowAsientosSeleccionados : [Int]
    @State var columnAsientosSeleccionados : [Int]
    @StateObject var functionViewModel = FunctionViewModel()
    


    var body: some View {
        VStack(spacing: 10) {
           
            
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
                Text("   ") // espacio en blanco para alineación
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
                            SeatView(seat: seat, row: rowIndex, column: columnIndex, asientosSeleccionados: $asientosSeleccionados, seats: $seats, rowAsientosSeleccionados: $rowAsientosSeleccionados, columnAsientosSeleccionados: $columnAsientosSeleccionados)
                        } else {
                            // asiento invisible
                            Rectangle()
                                .frame(width: 30, height: 30)
                                .opacity(0)
                        }
                    }
                    
                    
                }
            }

           // Spacer()
            
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
                        .foregroundColor(.gray)
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

        }
        .padding()
        .onAppear(){
            Task{
                await seats = functionViewModel.loadSeats(functionID: function.id!)
            }
        }
        
    }

    

}
