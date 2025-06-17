import SwiftUI

@MainActor
class SalesViewModel : ObservableObject {
    let BASE_URL = "https://shark-app-p8ovg.ondigitalocean.app"
    @Published var isSaleLoading = false
    @StateObject var functionViewModel = FunctionViewModel()
    @Published var sale: Sale?

    init(){
        Task {

        }
    }

    func loadSale(saleId: Int) async {
        guard let url = URL(string: "\(BASE_URL)/sales?id=\(saleId)") else { return }
        do{ 
            isSaleLoading = true
            let (data, _) = try await URLSession.shared.data(from: url)
            let saleDecoded = try JSONDecoder().decode(Sale.self, from: data)
            sale = saleDecoded
            isSaleLoading = false
        }
        catch{
            print("Error cargando la venta", error)
            isSaleLoading = false
        }
    }

    func createSale(username: String, mail: String, total: Double, numberOfSeats: Int, seatsReserved: [Seat], functionID: Int) async {
        guard let url = URL(string: "\(BASE_URL)/sales") else { return }
        let formatter = DateFormatter()
        await functionViewModel.reserveSeats(seatsReserved: seatsReserved, functionID: functionID);
        var seats : String = ""
        seatsReserved.forEach{seat in
            seats.append("\(seat.row)\(seat.column),")
        }
        struct CreateSaleRequest: Encodable {
            let saleDate: String // Or use Date and a custom encoder/formatter
            let username: String
            let mail: String
            let total: Double
            let numberOfSeats: Int
            let seatsReserved: String // String of comma-separated seats
            let functionID: Int
            // Add any other fields your API expects
        }
        let requestBody = CreateSaleRequest(
            saleDate: formatter.string(from: Date()),
            username: username,
            mail: mail,
            total: total,
            numberOfSeats: numberOfSeats,
            seatsReserved: seats, // The comma-separated string
            functionID: functionID
        )
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(requestBody)
            let (data, response) = try await URLSession.shared.data(for: request)
            print("Venta enviada correctamente:", response)
        } catch {
            print("Error enviando la venta:", error)
        }
    }


    func generateQR(){

    }

    func changeQRtoImage(){

    }
    

    
}
