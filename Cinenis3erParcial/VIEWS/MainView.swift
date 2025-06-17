//
//  MainView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 12/06/25.
//
import SwiftUI

struct MainView : View {
    
    @Binding var isDarkImage: Bool
    @State public var movies : [Movie]
    @State public var selectedFunction : Function? = nil
    @StateObject var functionViewModel = FunctionViewModel()

    var body: some View {
        ScrollView {
            CarouselMainView(isDarkImage: $isDarkImage)
                .frame(minHeight: 900)
            VStack {
                HStack (spacing: 50) {
                    //agregar funcion de filtrado
                    Categories(category: "Terror", videoName: "video_terror", movies: $movies)
                    Categories(category: "Comedia", videoName: "video_comedia", movies: $movies)
                    Categories(category: "Romance", videoName: "video_romance", movies: $movies)
                    Categories(category: "Ficción", videoName: "video_ficcion", movies: $movies)
                    Categories(category: "Infantiles", videoName: "video_infantil", movies: $movies)
                }
                .padding(.vertical, 50)
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack{
                        Spacer()
                        FechaHoyView(movies: $movies, functionViewModel: functionViewModel)
                    }
                    .padding(.leading, 80)
                    .padding(.vertical, 15)
                    
                    ForEach(movies){movie in
                        MovieMainView(movieID: movie.id!,image: movie.image, nombrePelicula: movie.title, clasificacion: movie.classification, duracion: movie.duration, categoria: movie.genre)
                        
                    }
                }
                .padding(.horizontal, 60)
                
              
                
                
            }
        }.onAppear(){
            Task{
                movies = await functionViewModel.loadBoard(date: fechaSeleccionada, genre: "any", premiere: false)
            }
        }
    }
}

#Preview {
    ContentView()
}
