//
//  ContentView.swift
//  Cinenis3erParcial
//
//  Created by ISSC_411_2024 on 10/06/25.
//
import SwiftUI


struct ContentView: View {
    @State private var isDarkImage = false
    @StateObject var functionViewModel = FunctionViewModel()
    var screen = NSScreen.main!.visibleFrame
    

    var body: some View {
        ZStack(alignment: .top) {
            TabView {
                MainView(isDarkImage: $isDarkImage, movies: functionViewModel.movieList)
                Text("Otra pestaña")
                Text("Más contenido")
            }

            MenuBar(isDarkImage: isDarkImage)
                .zIndex(1)
                .padding(.top, 50)
        }
        .frame(width: screen.width, height: screen.height)
        .edgesIgnoringSafeArea(.top)
    }

}


#Preview {
    ContentView()
}
