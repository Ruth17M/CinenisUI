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
        VStack {
            CarouselMainView(isDarkImage: $isDarkImage)

            HStack (spacing: 40) {
                Categories(categories: "Terror")
                Categories(categories: "Comedia")
                Categories(categories: "Romance")
                Categories(categories: "Ficción")
            }
            .padding(.vertical, 50)
            
        }
    }
}
#Preview {
    ContentView()
}
