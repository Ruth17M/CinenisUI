//
//  MovieMainView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 14/06/25.
//

import SwiftUI

struct MovieMainView: View {
    let movieID : Int
    let image : String
    let nombrePelicula : String
    let clasificacion : String
    let duracion : Int
    let categoria : String
    @StateObject var functionViewModel = FunctionViewModel()
    @State var funciones : [Function] = []

    var body: some View {
        
        HStack(spacing: 25){
            AsyncImage(url: URL(string: image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(width: 210, height: 260)
            .padding(.leading, 75)
            
            VStack(alignment: .leading, spacing: 22) {
                HStack(spacing: 20) {
                    Text(nombrePelicula)
                        .font(.system(size: 30))
                        .fontWeight(.light)
                    
                    Text(clasificacion)
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                        .frame(width: 33, height: 20)
                        .padding(5)
                        .background(Color(colorParaClasificacion(clasificacion)))
                        .clipShape(Capsule())
                        
                    
                }
                
                HStack{
                    Image(systemName: "clock")
                        .font(.system(size: 20))
                        .padding(0)
                    
                    Text(String("\(duracion) min"))
                        .font(.system(size: 40))
                        .fontWeight(.light)
                }

                Text(categoria)
                    .font(.system(size: 17))
                    .fontWeight(.light)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(colorParaCategoria(categoria)))
                    .clipShape(Capsule())
                
                Spacer()
                
                Text("Funciones")
                    .font(.system(size: 20))
                    .fontWeight(.light)

                HStack(spacing:23){
                    HorariosView(movieID: movieID, funciones: $funciones)
                }

            }
            .padding(.vertical, 15)
            
            
        }
        .padding(.vertical, 20)
    }
    
    func colorParaCategoria(_ categoria: String) -> Color {
        switch categoria {
        case "Terror": return Color(red: 188/255, green: 71/255, blue: 73/255)
        case "Comedia": return Color(red:251/255, green:133/255, blue:0/255)
        case "Romance": return Color(red: 237/255, green: 175/255, blue: 184/255)
        case "Ficción": return Color(red: 205/255, green: 180/255, blue: 219/255)
        case "Infantiles": return Color(red: 255/255, green: 183/255, blue: 3/255)
        case "Action": return Color(red: 33/255, green: 158/255, blue: 184/255)
        default: return .gray
        }
    }
    
    func colorParaClasificacion(_ clasificacion: String) -> Color {
        switch clasificacion {
            case "A": return Color(red: 176/255, green: 196/255, blue: 177/255)
            case "TBC": return Color(red: 237/255, green: 175/255, blue: 184/255)
            case "B15": return Color(red: 255/255, green: 214/255, blue: 10/255)
            case "C": return Color(red: 69/255, green: 123/255, blue: 157/255)
        default: return .gray
        }
    }
}
