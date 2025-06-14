//
//  MenuBar.swift
//  Cinenis3erParcial
//
//  Created by ISSC_411_2024 on 10/06/25.
//

import SwiftUI

import SwiftUI

struct MenuBar: View {
    var isDarkImage: Bool
    @State private var menuAbierto = false
    let categorias = ["Terror", "Comedia", "Romance", "Ficción", "Infantiles"]

    var body: some View {
        let textColor = isDarkImage ? Color.white : Color.black
        let logoName = isDarkImage ? "LogoBlanco" : "LogoNegro"

        HStack(spacing: 35) {
            Image(logoName)
                .resizable()
                .frame(width: 100, height: 65)
                .padding(10)

            Text("Estrenos")
                .font(.system(size: 20))
                .foregroundColor(textColor)

            Button(action: {
                withAnimation {
                    menuAbierto.toggle()
                }
            }) {
                Text("Categorías")
                    .font(.system(size: 20))
                    .frame(width: 100, height: 25)
                    .foregroundColor(textColor)
            }
            .buttonStyle(PlainButtonStyle())
            .overlay(
                Group {
                    if menuAbierto {
                        VStack(alignment: .center, spacing: 8) {
                            ForEach(categorias, id: \.self) { categoria in
                                Text(categoria)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 15))
                                    .padding(.horizontal)
                                    .padding(.vertical, 3)
                                    .cornerRadius(5)
                            }
                        }
                        .frame(width: 100)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .offset(y: 30)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                }, alignment: .topLeading
            )

            Text("Películas")
                .font(.system(size: 20))
                .foregroundColor(textColor)

            Spacer()

            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(textColor)

                TextField("Buscar películas", text: .constant(""))
                    .foregroundStyle(textColor)
                    .font(.system(size: 17))
                    .padding(5)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding(7)
            .overlay(
                Capsule()
                    .stroke(textColor, lineWidth: 1)
                    .opacity(1)
            )
            .frame(width: 180)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}


#Preview {
    ContentView()
}


