//
//  MovieMainView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 14/06/25.
//

import SwiftUI

struct MovieMainView: View {
    let image : String
    let nombrePelicula : String
    let clasificacion : String
    let duracion : String
    let categoria : String
    let colorCategoria : Color
    let colorClasificacion : Color
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
                        .background(Color(colorClasificacion))
                        .clipShape(Capsule())
                        
                    
                }
                
                HStack{
                    Image(systemName: "clock")
                        .font(.system(size: 20))
                        .padding(0)
                    
                    Text(duracion)
                        .font(.system(size: 20))
                        .fontWeight(.light)
                }

                Text(categoria)
                    .font(.system(size: 17))
                    .fontWeight(.light)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(colorCategoria))
                    .clipShape(Capsule())
                
                Spacer()
                
                Text("Funciones")
                    .font(.system(size: 20))
                    .fontWeight(.light)
                
                HStack(spacing:23){
                    Horarios(hora: "12:00")
                    Horarios(hora: "12:10")
                    Horarios(hora: "13:00")
                    Horarios(hora: "13:30")
                    Horarios(hora: "15:45")
                    Horarios(hora: "17:20")
                    Horarios(hora: "17:40")
                    Horarios(hora: "17:20")
                    Horarios(hora: "17:40")
                }

            }
            .padding(.vertical, 15)
            
        }
        .padding(.vertical, 20)
    }
}
