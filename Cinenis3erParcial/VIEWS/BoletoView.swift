//
//  BoletoView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 15/06/25.
//

import SwiftUI

struct BoletoView: View {
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
                           Text("Spider-Man: No Way Home")
                               .font(.title2)
                               .fontWeight(.bold)
                               .foregroundColor(.white)

                           AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/poUK5Gg7IkPokaBTjadzjPfJgKw.jpg")) { image in image
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
                               Label("150 min", systemImage: "hourglass")
                           }
                           .foregroundColor(.white)
                           .font(.subheadline)

                           Divider().background(Color.white)

                           HStack(spacing: 40) {
                               VStack {
                                   Text("SALÓN")
                                       .font(.caption)
                                       .foregroundColor(.white)
                                   Text("02")
                                       .font(.title2)
                                       .foregroundColor(.white)
                               }
                               VStack {
                                   Text("FILA")
                                       .font(.caption)
                                       .foregroundColor(.white)
                                   Text("5")
                                       .font(.title2)
                                       .foregroundColor(.white)
                               }
                               VStack {
                                   Text("ASIENTO")
                                       .font(.caption)
                                       .foregroundColor(.white)
                                   Text("18")
                                       .font(.title2)
                                       .foregroundColor(.white)
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
               }
    }
}
