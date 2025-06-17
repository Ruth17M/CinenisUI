//
//  Horarios.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 14/06/25.
//
import SwiftUI

struct Horarios: View {
    let funcionDate : Date
    @State var hora : String
    var body: some View {
        .onAppear {
            timeString(funcionDate: funcionDate)
        }
        Text(hora)
            .font(.system(size: 20, weight: .light))
            .padding(.vertical, 9)
            .padding(.horizontal, 19)
            .overlay(
                Capsule()
                    .stroke(Color.black, lineWidth: 1)
            )
    }
    
        func timeString(funcionDate: Date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm" // "HH" para formato de 24 horas, "mm" para minutos
            formatter.locale = Locale(identifier: "es_MX") // Opcional: Asegura el formato local si es necesario, aunque HH:mm es bastante universal.
            hora= formatter.string(from: date)
        }
}
