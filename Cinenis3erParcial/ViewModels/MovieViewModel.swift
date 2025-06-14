import SwiftUI

@MainActor
class MovieViewModel : ObservableObject {

    let BASE_URL = "https://seahorse-app-yy79u.ondigitalocean.app/"
    @Published var isMovieLoading = false 
    @Published var movieList: [Movie] = []

    init() {
        Task{
            loadMovies()
        }
    }

    func loadMovies() async {
        let url = URL(string: "\(BASE_URL)/movies")
        do{ 
            isMovieLoading = true
            let (data, _) = try await URLSession.shared.data(from: url!)
            let moviesDecoded = try JSONDecoder().decode([Movie].self, from: data)
            movieList = moviesDecoded
            isMovieLoading = false
        }
        catch{
            print("Error cargando las películas", error)
            isMovieLoading = false
        }
    }
}
