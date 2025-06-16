//
//  FechaHoyView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 13/06/25.
//

import SwiftUI

struct FechaHoyView: View {
    let calendar = Calendar(identifier: .gregorian)
    let diasSemana = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"]
    let hoy = Date()

    var body: some View {
        VStack(alignment: .leading) {
            Text(formatearFecha(hoy))
                .font(.system(size: 20, weight: .light))
            
            Divider()
                .background(Color("ColorNegro"))
                .frame(width: 1200)
            
            // Días de la semana
            HStack(spacing: 100) {
                ForEach(diasSemana, id: \.self) { dia in
                    Text(dia)
                }
            }
            .padding(.leading, 60)
            .padding(.vertical, 5)
            .font(.system(size: 20))
            .fontWeight(.light)

            // Días del mes con estilo
            HStack(spacing: 135) {
                ForEach(0..<7) { index in
                    let fecha = calcularFecha(para: index)
                    let numero = calendar.component(.day, from: fecha)
                    let estilo = estiloPara(fecha: fecha)

                    Text("\(numero)")
                        .font(.system(size: 20))
                        .fontWeight(estilo.esHoy ? .bold : .regular)
                        .foregroundColor(estilo.esPasado ? .gray : .primary)
                        .strikethrough(estilo.esPasado, color: .gray)
                        .padding(6)
                        .background(estilo.esHoy ? Color("ColorAmarillo") : Color.clear)
                        .clipShape(Circle())
                }
            }
            .padding(.leading, 75)
        }
    }

    func formatearFecha(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.dateFormat = "EEEE d 'de' MMMM"
        return formatter.string(from: date).capitalized
    }

    func calcularFecha(para index: Int) -> Date {
        let diaSemanaActual = (calendar.component(.weekday, from: hoy) + 5) % 7 // lunes = 0
        let diferencia = index - diaSemanaActual
        return calendar.date(byAdding: .day, value: diferencia, to: hoy)!
    }

    func estiloPara(fecha: Date) -> (esHoy: Bool, esPasado: Bool) {
        if calendar.isDate(fecha, inSameDayAs: hoy) {
            return (true, false)
        } else if fecha < hoy {
            return (false, true)
        } else {
            return (false, false)
        }
    }
}


