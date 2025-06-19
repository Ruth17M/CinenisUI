//
//  DetallesMovieView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 11/06/25.
//

import SwiftUI

struct DetallesMovieView: View {
    let movie: Movie
    
    var body: some View {
        VStack(spacing: 0) {
            
            AsyncImage(url: URL(string: movie.image)) { image in
                image
                    .resizable()
                    .frame(maxWidth: 386, maxHeight: 350)
            } placeholder: {
                ProgressView()
            }
            
            // Recuadro con la información
            VStack(alignment: .leading, spacing: 8) {
                Text("Director").bold()
                Text(movie.director)
                
                Text("Actores").bold()
                Text(movie.actors)
                
                Text("Descripción").bold()
                Text(movie.description)

                HStack {
                    ForEach(0..<movie.stars, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color("ColorGris"))
        }
        .shadow(radius: 5)

            }
}

