//
//  MovieView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 11/06/25.
//


import SwiftUI

struct MovieView: View {
    //Objeto Pelicula para prueba de MovieView
    let movie : MovieModel
    var body: some View {
        ZStack {

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



