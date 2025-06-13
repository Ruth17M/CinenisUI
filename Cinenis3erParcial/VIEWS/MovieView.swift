//
//  MovieView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 11/06/25.
//


import SwiftUI

struct MovieView: View {
    //Objeto Pelicula para prueba de MovieView
    let movie = Movie(
          title: "IRON MAN",
          director: "John Favreau",
          actors: "Downey JR, Howard, Bridges",
          description: "Iron Man posee una armadura motorizada que le brinda fuerza y resistencia sobrehumanas",
          posterImage: "ironman_poster",
          backgroundImage: "ironman_background",
          rating: 5
      )
    var body: some View {
        ZStack {
                   Image(movie.backgroundImage)
                       .resizable()
                       .scaledToFill()
                       .overlay(LinearGradient(
                           gradient: Gradient(colors: [.black.opacity(0.8), .black]),
                           startPoint: .top,
                           endPoint: .bottom)
                       )
                       .edgesIgnoringSafeArea(.all)

                   HStack(spacing: 0) {
                           DetallesMovieView(movie: movie)
                                 .frame(width: 300)
                                 .background(Color.black)

                       Divider()

                       VStack {
                           Text(movie.title)
                               .font(.largeTitle)
                               .foregroundColor(.white)
                               .padding(.top)

                         //  SeatsView()
                       }
                       .padding()
                   }
               }
    }
    }

