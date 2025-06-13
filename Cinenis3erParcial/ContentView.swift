//
//  ContentView.swift
//  Cinenis3erParcial
//
//  Created by ISSC_411_2024 on 10/06/25.
//
import SwiftUI

struct ContentView: View {
    @State private var isDarkImage = false
    @State private var selectedTab = 0

    var body: some View {
        ZStack(alignment: .top) {
            // Contenido dinámico por pestañas
            TabView(selection: $selectedTab) {
                MainView(isDarkImage: $isDarkImage)
                    .tag(0)
                Text("Otra pestaña")
                    .tag(1)
                Text("Otra más")
                    .tag(2)
            }

            // Menú encima de todo
            MenuBar(isDarkImage: isDarkImage)
                .padding(.top, 40)
                .zIndex(1)
        }
        .edgesIgnoringSafeArea(.top)
        VStack {
            HStack{
                Text("Miercoles, 4 de junio")
                    .font(.title2)
                Spacer()
                
            }
            .padding(.leading, 80)
            
            HStack{
                
            }
            
            
            
        }
        
        
    }
}


#Preview {
    ContentView()
}
