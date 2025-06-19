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
    @State private var isScrolledPastCarousel = false  // <-- Nuevo estado
    var screen = NSScreen.main!.visibleFrame

    var body: some View {
        ZStack(alignment: .top) {
            MainView(isDarkImage: $isDarkImage,
                     movies: functionViewModel.movieList,
                     isScrolledPastCarousel: $isScrolledPastCarousel)  // <-- Pasar binding
            
            MenuBar(isDarkImage: isDarkImage,
                    hasBackground: isScrolledPastCarousel)  // <-- Pasar estado al menú
                .zIndex(1)
                
        }
        .frame(width: screen.width, height: screen.height)
        .edgesIgnoringSafeArea(.top)
        //.padding()
    }
}
