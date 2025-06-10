//
//  MenuBar.swift
//  Cinenis3erParcial
//
//  Created by ISSC_411_2024 on 10/06/25.
//

import SwiftUI

struct MenuBar: View {
    @State private var menuAbierto = false
    let categorias = ["Terror", "Comedia", "Romance", "Ficción", "Infantiles"]

    var body: some View {
        HStack(spacing: 35) {
            Image("Logo")
                .resizable()
                .frame(width: 85, height: 50)
                .padding(10)

            Text("Estrenos")
                .font(.system(size: 15))

            Button(action: {
                withAnimation {
                    menuAbierto.toggle()
                }
            }) {
                Text("Categorías")
                    .font(.system(size: 15))
                    .frame(width: 90, height: 25) // tamaño fijo para que no cambie
            }
            .buttonStyle(PlainButtonStyle())
            .overlay(
                Group {
                    if menuAbierto {
                        VStack(alignment: .center, spacing: 8) {
                            ForEach(categorias, id: \.self) { categoria in
                                Text(categoria)
                                    .foregroundColor(Color.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 3)
                                    .cornerRadius(5)
                            }
                        }
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .offset(y: 30) // justo debajo del texto
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                }, alignment: .topLeading
            )

            Text("Películas")
                .font(.system(size: 15))

            Spacer()

            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("MenuTexto").opacity(1))

                TextField("Buscar películas", text: .constant(""))
                    .foregroundStyle(Color("MenuTexto").opacity(1))
                    .font(.system(size: 12))
                    .padding(5)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding(5)
            .overlay(
                Capsule()
                    .stroke(Color("MenuTexto"), lineWidth: 0.5)
                    .opacity(1)
            )
            .frame(width: 180)
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        Spacer()
    }
}

#Preview {
    ContentView()
}


