import SwiftUI

@MainActor
class SalesViewModel : ObservableObject {
    let BASE_URL = "https://seahorse-app-yy79u.ondigitalocean.app/"
    @Published var isSaleLoading = false
    @Published var sale: Sale 

    init(){
        Task {

        }
    }

    func loadSale(saleId: Int) async {
        let url = URL(string: "\(BASE_URL)/sales?id=\(saleId)")
        do{ 
            isSaleLoading = true
            let (data, _) = try await URLSession.shared.data(from: url!)
            let saleDecoded = try JSONDecoder().decode(SaleModel.self, from: data)
            sale = saleDecoded
            isSaleLoading = false
        }
        catch{
            print("Error cargando la venta", error)
            isSaleLoading = false
        }
    }

    
}