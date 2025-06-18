//
//  MainView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 12/06/25.
//
import SwiftUI

struct MainView: View {
    @Binding var isDarkImage: Bool
    @State public var movies: [Movie]
    @State public var selectedFunction: Function? = nil
    @StateObject var functionViewModel = FunctionViewModel()
    @Binding var isScrolledPastCarousel: Bool  // <-- Nuevo binding
    @State private var categoriaSeleccionada: String = "any"


    var body: some View {
        ScrollView {
            GeometryReader { geo in
                CarouselMainView(isDarkImage: $isDarkImage)
                    .frame(minHeight: 1200)
                    .onChange(of: geo.frame(in: .global).maxY) { maxY in
                        // Si el carrusel ya no está en pantalla (o muy arriba), activa fondo
                        withAnimation {
                            isScrolledPastCarousel = maxY < 100 // Ajusta este valor a lo que convenga
                        }
                    }
            }
            .frame(height: 1200) // Igual que el minHeight para que GeometryReader mida bien
            
            VStack {
                // resto igual
                HStack(spacing: 40) {
                    Categories(category: "Terror", videoName: "video_terror", movies: $movies)
                    Categories(category: "Comedia", videoName: "video_comedia", movies: $movies)
                    Categories(category: "Romance", videoName: "video_romance", movies: $movies)
                    Categories(category: "Ficción", videoName: "video_ficcion", movies: $movies)
                    Categories(category: "Infantiles", videoName: "video_infantil", movies: $movies)
                    Categories(category: "Action", videoName: "video_accion", movies: $movies)
                }
                .padding(.top, 50)
                .padding(.bottom, 20)
                
                Button(action: {
                    Task {
                        categoriaSeleccionada = "any"
                        movies = await functionViewModel.loadBoard(date: fechaSeleccionada, genre: "any", premiere: false)
                    }
                }) {
                    Text("Ver todas las categorías")
                        .font(.system(size: 18, weight: .medium))
                        .fontWeight(.light)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .foregroundColor(Color("MenuTexto"))
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.vertical, 10)
                

                
                VStack(alignment: .center, spacing: 20) {
                    FechaHoyView(movies: $movies, functionViewModel: functionViewModel)
                        .padding(.vertical, 15)

                    ForEach(movies) { movie in
                        MovieMainView(movieID: movie.id!, image: movie.image, nombrePelicula: movie.title, clasificacion: movie.classification, duracion: movie.duration, categoria: movie.genre)
                            .frame(width: 1490)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            Task {
                movies = await functionViewModel.loadBoard(date: fechaSeleccionada, genre: "any", premiere: false)
            }
        }
    }
}
