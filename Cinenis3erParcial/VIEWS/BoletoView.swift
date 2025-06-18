//
//  BoletoView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 15/06/25.
//

import SwiftUI
import AppKit

struct BoletoView: View {
    var username: String
    var mail: String
    var total: Double
    var cantidadBoletos : Int
    var asientosSeleccionados : [Seat]
    var funcionSeleccionada : Function
    @StateObject var salesViewModel = SalesViewModel()
    var body: some View {
        ZStack {
                   // Fondo con imagen y degradado
                   Image("teatro_background")
                       .resizable()
                       .scaledToFill()
                       .ignoresSafeArea()
                       .overlay(
                           LinearGradient(
                               gradient: Gradient(colors: [.black.opacity(0.6), .black]),
                               startPoint: .top,
                               endPoint: .bottom
                           )
                       )

                   VStack(spacing: 20) {
                       Text("Disfruta tu función")
                           .font(.largeTitle)
                           .fontWeight(.bold)
                           .foregroundColor(.white)
                           .padding(.top, 30)

                       VStack(spacing: 15) {
                           Text(funcionSeleccionada.movie.title)
                               .font(.title2)
                               .fontWeight(.bold)
                               .foregroundColor(.white)

                           AsyncImage(url: URL(string: funcionSeleccionada.movie.image)) { image in image
                                   .resizable()
                                   .scaledToFill()
                                   .frame(width: 180, height: 260)
                                   .cornerRadius(12)
                                   .clipped()
                           } placeholder: {
                               ProgressView()
                           }

                           HStack(spacing: 20) {
                               Label("5 Feb", systemImage: "calendar")
                               Label("6:00 PM", systemImage: "clock")
                               Label(String(funcionSeleccionada.movie.duration), systemImage: "hourglass")
                           }
                           .foregroundColor(.white)
                           .font(.subheadline)

                           Divider().background(Color.white)

                           HStack(spacing: 40) {
                               VStack {
                                   Text("SALÓN")
                                       .font(.caption)
                                       .foregroundColor(.white)
                                   Text(String(funcionSeleccionada.room))
                                       .font(.title2)
                                       .foregroundColor(.white)
                               }
                               VStack {
                                   Text("ASIENTOS")
                                       .font(.caption)
                                       .foregroundColor(.white)
                                   ForEach(asientosSeleccionados){seat in
                                       Text(seat.id)
                                           .font(.title2)
                                           .foregroundColor(.white)
                                   }
                                   
                               }
                           }

                           // Código de barras simulado
                           Rectangle()
                               .fill(Color.white)
                               .frame(height: 40)
                               .overlay(Text("|||||||||||||||||||||||||").font(.caption2).foregroundColor(.black))
                       }
                       .padding()
                       .background(Color.red.opacity(0.9))
                       .cornerRadius(25)
                       .frame(maxWidth: 300)
                       .shadow(radius: 12)
                   }
        }.onAppear(){
            Task{
                Task{
                    await salesViewModel.createSale(username: username, mail: mail, total: total, numberOfSeats: cantidadBoletos, seatsReserved: asientosSeleccionados, functionID: funcionSeleccionada.id!)
                    if let sale = salesViewModel.saleRecieved {More actions
                        let qrBase64 = salesViewModel.generateQR(from: sale)
                        salesViewModel.saleRecieved?.qrCode = qrBase64
                        let qrImage = salesViewModel.changeQRtoImage()
                }
            }
        }
    }
}
