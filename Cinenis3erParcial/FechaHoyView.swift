//
//  FechaHoyView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 13/06/25.
//

import SwiftUI

struct FechaHoyView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(formatearFecha(Date()))
                .font(.system(size: 20, weight: .light))
                
            
            Divider()
                .background(Color("ColorNegro"))
                .frame(width: 1200)
            
            HStack (spacing: 100) {
                Text("Lunes")
                Text("Martes")
                Text("Miércoles")
                Text("Jueves")
                Text("Viernes")
                Text("Sábado")
                Text("Domingo")
            }
            .padding(.leading, 60)
            .font(.system(size: 20))
            .fontWeight(.light)
        }
    }

    func formatearFecha(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.dateFormat = "EEEE d 'de' MMMM"
        return formatter.string(from: date).capitalized
    }
}


