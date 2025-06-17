//
//  MovieView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 11/06/25.
//


import SwiftUI

struct MovieView: View {
    var function : Function
    @StateObject var functionViewModel = FunctionViewModel()
    @StateObject var salesViewModel = SalesViewModel()
    @State var movie : Movie
    @State var funciones : [Function]
    @State var funcionSeleccionada : Function
    @State var cantidadBoletos : Int = 3
    @State var asientosSeleccionados : [Seat] = []
    
    var classification: String {
            movie.classification
    }

    var colorClasificacion: Color {
            switch movie.classification {
            case "A": return .green
            case "B": return .blue
            case "C": return .red
            case "R": return Color(red: 255/255, green: 166/255, blue: 43/255)
            default: return .gray
            }
    }

    @State private var isDarkImage = true

        // Initialize movie within the custom initializer
    init(function: Function) {
            self.function = function // First, initialize the 'function' property
            self._movie = State(initialValue: function.movie) // Then, initialize the @State 'movie'
            self.funcionSeleccionada = function
            self.funciones = []
    }

    
    var body: some View {
    
        ScrollView {
            
            
            ZStack(alignment: .topLeading){
                
                // Fondo con gradiente
                //Cambiar a imagen estatica
                /*Image(nmovie.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .overlay(LinearGradient(
                        gradient: Gradient(colors: [.black.opacity(0.8), .black]),
                        startPoint: .top,
                        endPoint: .bottom)
                    )
                    .edgesIgnoringSafeArea(.all)
                */
             
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
                                       .font(.title)
                                       .foregroundColor(.white)
                                Spacer()

                                Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                                      .resizable()
                                      .frame(width: 25, height: 25)
                                      .foregroundColor(.white)
                                Text("\(movie.duration)")
                                        .font(.subheadline)
                                        .foregroundColor(.white)

                                Text(movie.classification)
                                        .font(.system(size: 17))
                                        .foregroundColor(Color(.white))
                                            .fontWeight(.regular)
                                            .frame(width: 33, height: 20)
                                            .padding(5)
                                            .background(Color.clear)
                                            .overlay(
                                                Capsule()
                                                    .stroke(Color(colorClasificacion), lineWidth: 1)
                                            )
                            }
                            // Seccion Horarios y Fecha
                            HStack(alignment: .top) {
                                       
                                       // FECHA
                                       VStack(alignment: .leading, spacing: 10) {
                                           Text("Fecha")
                                               .font(.system(size: 16, weight: .regular))
                                               .foregroundColor(.white)

                                           Divider().background(Color.white)
                                           
                                           FechaMovieView(funciones: $funciones)
                                           
                                          // Divider().background(Color.white)
                                       }
                                       .frame(width: 300)
                                       
                                       Spacer()
                                       
                                       // HORARIOS
                                       VStack(alignment: .leading, spacing: 10) {
                                           Text("Horario")
                                               .font(.system(size: 16, weight: .regular))
                                               .foregroundColor(.white)

                                        
                                           Divider().background(Color.white)
                                           
                                           HorariosView(movieID: movie.id!, functionViewModel: functionViewModel, funciones: $funciones)
                                           
                                         //  Divider().background(Color.white)
                                       }
                                       .frame(width: 300)
                                   }
                                   .padding(.horizontal, 40)
                               
                           
                            SeatGridView(function: funcionSeleccionada,numeroAsientos: $cantidadBoletos, asientosSeleccionados: $asientosSeleccionados, rowAsientosSeleccionados: [], columnAsientosSeleccionados: [])
                        }
                        .padding(.trailing, 100)
                        .padding(.top,200)
                     }
                    
                    // MenuBar
                    MenuBar(isDarkImage: isDarkImage)
                        .padding(.top, 5)
                        .zIndex(1)
                        .frame(maxWidth: .infinity, alignment: .top)
                 
                
                HStack{
                    NavigationLink(destination: BoletoView(username: "estatico", mail: "Estatico", total: Double(cantidadBoletos)*80.00, cantidadBoletos: cantidadBoletos, asientosSeleccionados: asientosSeleccionados, funcionSeleccionada: funcionSeleccionada)) {
                                               Image(systemName: "arrow.left.circle.fill")
                                                   .resizable()
                                                   .frame(width: 40, height: 40)
                                                   .foregroundColor(.yellow)
                                                   .padding()
                                           }
                }
            }.onAppear() {
                Task{
                    funciones = await functionViewModel.loadFunctionsByMovie(movieID: movie.id!, date: fechaSeleccionada)
                    selectedMovieID = movie.id!
                }
            }
        }.onChange(of: fechaSeleccionada) { newDate in // newDate is the new value of fechaSeleccionada
            Task { // <--- Wrap your async call in a Task
                do {
                    // Make sure movie.id is not nil
                    if let movieID = movie.id {
                        self.funciones = await functionViewModel.loadFunctionsByMovie(movieID: movieID, date: newDate)
                    } else {
                        print("Error: movie.id es nil en onChange")
                    }
                } catch {
                    print("Error al cargar funciones en onChange: \(error)")
                }
            }
        }
            
            
            
        }
    }
    



