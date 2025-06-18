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
                HStack (spacing: 40) {
                    //agregar funcion de filtrado
                    Categories(category: "Terror", videoName: "video_terror", movies: $movies)
                    Categories(category: "Comedia", videoName: "video_comedia", movies: $movies)
                    Categories(category: "Romance", videoName: "video_romance", movies: $movies)
                    Categories(category: "Ficción", videoName: "video_ficcion", movies: $movies)
                    Categories(category: "Infantiles", videoName: "video_infantil", movies: $movies)
                    Categories(category: "Action", videoName: "video_accion", movies: $movies)
                }
                .padding(.vertical, 50)
                
                VStack(alignment: .center, spacing: 20) {
                    FechaHoyView(movies: $movies, functionViewModel: functionViewModel)
                        .padding(.vertical, 15)
                        // Opcional: fijar un maxWidth para no ocupar toda la pantalla si quieres

                    ForEach(movies) { movie in
                        MovieMainView(movieID: movie.id!, image: movie.image, nombrePelicula: movie.title, clasificacion: movie.classification, duracion: movie.duration, categoria: movie.genre)
                            //.frame(maxWidth: .infinity, alignment: .center)
                            .frame(width: 1490)  // ancho fijo
                            .frame(maxWidth: .infinity)  // centra el frame fijo
                    }
                }
                .padding(.horizontal, 20)  // menos padding para dar margen pero no tanto como antes

                
              
                
                
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
