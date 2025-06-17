//
//  SeatView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 13/06/25.
//



import SwiftUI

struct SeatView: View {
    var seat: Seat
    let row: Int
    let column: Int
    @Binding var asientosSeleccionados : [Seat]
    @Binding var seats : [[Seat]]
    @Binding var rowAsientosSeleccionados : [Int]
    @Binding var columnAsientosSeleccionados : [Int]
    
    
    var body: some View {
        
        
        //figura de asiento
        
        Image(systemName: "carseat.left.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundColor(color(for: seat.status))
            .onTapGesture {
                if(asientosSeleccionados.count < 3 && seat.status == SeatStatus.available){
                    asientosSeleccionados.append(seat)
                    rowAsientosSeleccionados.append(row)
                    columnAsientosSeleccionados.append(column)
                    seats[row][column].status = SeatStatus.selected
                }else if(asientosSeleccionados.count == 3 && seat.status == SeatStatus.available){
                    asientosSeleccionados[0].status = SeatStatus.available
                    seats[rowAsientosSeleccionados[0]][columnAsientosSeleccionados[0]].status = SeatStatus.available
                    asientosSeleccionados.removeFirst()
                    rowAsientosSeleccionados.removeFirst()
                    columnAsientosSeleccionados.removeFirst()
                    asientosSeleccionados.append(seat)
                    rowAsientosSeleccionados.append(row)
                    columnAsientosSeleccionados.append(column)
                    seats[row][column].status = SeatStatus.selected
                }
                
            }
           
    }
    
    func color(for status: SeatStatus) -> Color {
        switch status {
        case .available:
            return .green
        case .selected:
            return .yellow
        case .occupied:
            return .gray
            
        }
    }
    
    
}
