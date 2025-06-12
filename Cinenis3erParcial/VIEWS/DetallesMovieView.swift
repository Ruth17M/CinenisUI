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
        VStack(alignment: .leading) {
            Image(movie.posterImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)

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
        .background(Color.black)    }
}
