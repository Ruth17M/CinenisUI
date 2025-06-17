//
//  FechaMovieView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 15/06/25.
//


import SwiftUI

struct FechaMovieView: View {
    let calendar = Calendar(identifier: .gregorian)
    let hoy = Date()
    @StateObject var functionViewModel = FunctionViewModel()
    @Binding var funciones : [Function] 


    var body: some View {
        
       
        
        HStack(spacing: 16) {
            ForEach(0..<7) { index in
                let fecha = calcularFecha(para: index)
                let dia = diaSemana(fecha: fecha)
                let numero = calendar.component(.day, from: fecha)
                let estilo = estiloPara(fecha: fecha)
              
                Button {
                    fechaSeleccionada = fecha
                    Task{
                        funciones = await functionViewModel.loadFunctionsByMovie(movieID: selectedMovieID!, date: fecha)
                    }
                } label: {
                    VStack(spacing: 4) {
                        Text(dia)
                            .font(.caption)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .light))
                        Text("\(numero)")
                            .font(.subheadline)
                            .fontWeight(estilo.esHoy ? .bold : .regular)
                            .foregroundColor(estilo.esPasado ? .gray : .white)
                            .frame(width: 28, height: 28)
                            .background(estilo.esHoy ? Color("ColorAmarillo") : Color.clear)
                            .clipShape(Circle())
                            .font(.system(size: 15, weight: .light))
                    }
                }.buttonStyle(PlainButtonStyle())

                
                
                
            }
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
    
    func diaSemana(fecha: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.dateFormat = "E"
        return formatter.string(from: fecha).capitalized
    }

}
