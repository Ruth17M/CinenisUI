//
//  ContentView.swift
//  Cinenis3erParcial
//
//  Created by ISSC_411_2024 on 10/06/25.
//
import SwiftUI


struct ContentView: View {
    @State private var isDarkImage = false
    @State public var movies : [MovieModel] = []
    var screen = NSScreen.main!.visibleFrame
    

    var body: some View {
        ZStack(alignment: .top) {
            TabView {
                MainView(isDarkImage: $isDarkImage, movies: movies)
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
    func loadProduct() async {
            do{
                let url = URL(string: "https://seahorse-app-yy79u.ondigitalocean.app/movies")
                let (data,_) = try await URLSession.shared.data(from: url!)
                let decoded = try JSONDecoder().decode([MovieModel].self, from: data)
                movies = decoded
            } catch let error {
                print(error)
            }
        }

}


#Preview {
    ContentView()
}
