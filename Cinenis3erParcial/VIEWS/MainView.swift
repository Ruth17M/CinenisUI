//
//  MainView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 12/06/25.
//
import SwiftUI

struct MainView : View {
    
    @Binding var isDarkImage: Bool
    @State public var movies : [MovieModel]

    var body: some View {
        ScrollView {
            CarouselMainView(isDarkImage: $isDarkImage)
                .frame(minHeight: 900)
            VStack {
                HStack (spacing: 50) {
                    Categories(category: "Terror", videoName: "video_terror")
                    Categories(category: "Comedia", videoName: "video_comedia")
                    Categories(category: "Romance", videoName: "video_romance")
                    Categories(category: "Ficción", videoName: "video_ficcion")
                    Categories(category: "Infantiles", videoName: "video_infantil")
                }
                .padding(.vertical, 50)
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack{
                        FechaHoyView()                      
                        Spacer()
                        
                    }
                    .padding(.leading, 80)
                    .padding(.vertical, 15)
                    
                    
                    HStack{
                        AsyncImage(url: URL(string: "https://m.media-amazon.com/images/I/81lZ6xboAfL.jpg")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(width: 250, height: 300)

                    }
                    .padding(.leading, 50)
                    
                    NavigationLink("Ir a la vista de detalle movie",destination: MovieView(movie: movies[0]))
                        .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal, 60)
                
                
            }
        }
    }
}
#Preview {
    ContentView()
}

