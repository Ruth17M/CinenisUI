//
//  MovieView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 11/06/25.
//


import SwiftUI

struct MovieView: View {
    //Objeto Pelicula para prueba de MovieView
    let movie = Movie(
        title: "IRON MAN",
        director: "John Favreau",
        actors: "Downey JR, Howard, Bridges",
        description: "Iron Man posee una armadura motorizada que le brinda fuerza y resistencia sobrehumanas",
        posterImage: "ironman_poster",
        backgroundImage: "teatro_background",
        rating: 3
    )
    @State private var isDarkImage = true
    var body: some View {
        
        ScrollView {
            
            
            ZStack(alignment: .topLeading){
                
                // Fondo con gradiente
                Image(movie.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .overlay(LinearGradient(
                        gradient: Gradient(colors: [.black.opacity(0.8), .black]),
                        startPoint: .top,
                        endPoint: .bottom)
                    )
                    .edgesIgnoringSafeArea(.all)
                
             
                //Detalles y asientos
                HStack{
                    
                    //Recuadro Detalles View
                    DetallesMovieView(movie: movie)
                        .frame(width: 400)
                        .padding(.leading, 150) //padding pelicula
                        .padding(.top, 40) //padding pelicula
                    
                    
                    
                    //Parte derecha de interfaz
       
                        VStack(alignment: .leading, spacing: 20){
                          
                            HStack{
                                Text(movie.title)
                                       .font(.largeTitle)
                                       .foregroundColor(.white)
                                Spacer()
                                
                            Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                                      .resizable()
                                      .frame(width: 25, height: 25)
                                      .foregroundColor(.white)
                            Text("2h 6m")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                
                                Text("PG-13")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                            }
                          
                            Spacer()
                               
                            SeatGridView()
                        }
                        .padding(.trailing, 100)
                        .padding(.top,200)
                     }
                    
                    // MenuBar
                    MenuBar(isDarkImage: isDarkImage)
                        .padding(.top, 5)
                        .zIndex(1)
                        .frame(maxWidth: .infinity, alignment: .top)
                    
                }
            }
            
            
            
        }
    }
    

