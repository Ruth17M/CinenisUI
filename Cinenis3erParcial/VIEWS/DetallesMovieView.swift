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
            
            // Imagen arriba, ocupando todo el ancho del recuadro
            Image(movie.posterImage)
                .resizable()
                .frame(maxWidth: 350, maxHeight: 410)
            
            // Recuadro con la información
            VStack(alignment: .leading, spacing: 8) {
                Text("Director").bold()
                Text(movie.director)

                Text("Actores").bold()
                Text(movie.actors)

                Text("Descripción").bold()
                Text(movie.description)

                HStack {
                    ForEach(0..<movie.rating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color("ColorGris"))
        }
       // .cornerRadius(10)
        .shadow(radius: 5)

            }
}
