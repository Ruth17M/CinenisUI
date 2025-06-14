import SwiftUI

@MainActor
class SalesViewModel : ObservableObject {
    let BASE_URL = "https://seahorse-app-yy79u.ondigitalocean.app/"
    @Published var isSaleLoading = false
    @Published var saleList [Sale] = []

    init(){
        Task {

        }
    }

    func loadSales() async {
        let url = URL(string: "\(BASE_URL)/sales")
        do{ 
            isSaleLoading = true
            let (data, _) = try await URLSession.shared.data(from: url!)
            let salesDecoded = try JSONDecoder().decode([Sale].self, from: data)
            saleList = salesDecoded
            isSaleLoading = false
        }
        catch{
            print("Error cargando las ventas", error)
            isSaleLoading = false
        }
    }
}