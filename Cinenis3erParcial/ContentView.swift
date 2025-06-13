//
//  ContentView.swift
//  Cinenis3erParcial
//
//  Created by ISSC_411_2024 on 10/06/25.
//
import SwiftUI

struct ContentView: View {
    @State private var isDarkImage = false

    var body: some View {
        ZStack(alignment: .top) {
            TabView {
                MainView(isDarkImage: $isDarkImage)
                Text("Otra pestaña")
                Text("Más contenido")
            }

            MenuBar(isDarkImage: isDarkImage)
                .zIndex(1)
                .padding(.top, 50)
        }
        .edgesIgnoringSafeArea(.top)
    }
}


#Preview {
    ContentView()
}
