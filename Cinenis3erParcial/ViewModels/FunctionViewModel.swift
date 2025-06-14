import SwiftUI

@MainActor
class FunctionViewModel : ObservableObject {

    let BASE_URL = "https://seahorse-app-yy79u.ondigitalocean.app/"
    @Published var isFunctionLoading = false 
    @Published var functionList: [Function] = []

    init() {
        Task{
            loadFunctions()
        }
    }

    func loadFunctions() async {
        let url = URL(string: "\(BASE_URL)/function")
        do{ // _ NO SE OCUPA EL SEGUNDO DATO, datos vienen en json
            isFunctionLoading = true
            let (data, _) = try await URLSession.shared.data(from: url!)
            let functionsDecoded = try JSONDecoder().decode([Function].self, from: data)
            functionList = functionsDecoded
            isfunctionLoading = false
        }
        catch{
            print("Error cargando las funciones", error)
            isfunctionLoading = false
        }
    }
}