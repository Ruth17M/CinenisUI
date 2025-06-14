//
//  DetallesMovieView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 11/06/25.
//

import SwiftUI

struct DetallesMovieView: View {
    let movie: MovieModel
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: movie.image))
            {image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
            }placeholder: {
                Color.gray
            }
                
            
            Text("Actores").bold()
            Text(movie.genre)
            
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
        .background(Color.black)    }
}

