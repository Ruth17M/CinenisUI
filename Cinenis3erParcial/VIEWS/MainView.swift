//
//  MainView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 12/06/25.
//
import SwiftUI

struct MainView : View {
    
    @Binding var isDarkImage: Bool

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
                    
                    
                    MovieMainView(image: "https://www.mubis.es/media/articles/9468/88340/trailer-y-poster-de-el-libro-de-la-vida-producida-por-guillermo-del-toro-original.jpg", nombrePelicula: "El Libro de la Vida", clasificacion: "A", duracion: "180 min", categoria: "Infantil", colorCategoria: Color("ColorAmarillo"), colorClasificacion: Color(red: 204/255, green: 213/255, blue: 174/255))
                    
                    MovieMainView(image: "https://musicart.xboxlive.com/7/ba7e4900-0000-0000-0000-000000000002/504/image.jpg", nombrePelicula: "Eso", clasificacion: "R", duracion: "210 min", categoria: "Terror", colorCategoria:Color(red: 224/255, green: 30/255, blue: 55/255), colorClasificacion: Color(red: 188/255, green: 71/255, blue: 73/255))
                    
                    MovieMainView(image: "https://m.media-amazon.com/images/M/MV5BMGUzYzljOWMtYTRmMy00MjY2LWFjNGQtM2UyMTFiMzA3NzgxXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg", nombrePelicula: "Cómo perder a un hombre en 10 días", clasificacion: "B15", duracion: "120 min", categoria: "Romance", colorCategoria: Color(red: 255/255,green: 202/255,blue: 212/255), colorClasificacion: Color(red: 255/255, green: 166/255, blue: 43/255))
                    
                    MovieMainView(image: "https://image.tmdb.org/t/p/original/poUK5Gg7IkPokaBTjadzjPfJgKw.jpg", nombrePelicula: "Son Como Niños", clasificacion: "A", duracion: "110 min", categoria: "Comedia", colorCategoria:Color(red: 251/255, green: 139/255, blue: 36/255), colorClasificacion: Color(red: 204/255, green: 213/255, blue: 174/255))
                    
                    NavigationLink("Ir a la vista de detalle movie", destination: MovieView() )
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
