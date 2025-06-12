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
            CarouselMainView(isDarkImage: $isDarkImage)

            MenuBar(isDarkImage: isDarkImage)
                .zIndex(1)
                .padding(.vertical, 40)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
