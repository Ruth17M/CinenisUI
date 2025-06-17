import SwiftUI

@MainActor
class SalesViewModel : ObservableObject {
    let BASE_URL = "https://shark-app-p8ovg.ondigitalocean.app"
    @Published var isSaleLoading = false
    @StateObject var functionViewModel = FunctionViewModel()
    @Published var sale: Sale?
    @Published var saleRecieved: SaleModel?
    init(){
        Task {

        }
    }
    

    func loadSale(saleId: Int) async -> SaleModel? {
        guard let url = URL(string: "\(BASE_URL)/sales?id=\(saleId)") else { return saleRecieved! }
        do{
            isSaleLoading = true
            let (data, _) = try await URLSession.shared.data(from: url)
            let saleDecoded = try JSONDecoder().decode(SaleModel.self, from: data)
            saleRecieved = saleDecoded
            isSaleLoading = false
            return saleRecieved!
        }
        catch{
            print("Error cargando la venta", error)
            isSaleLoading = false
            return saleRecieved!
        }
    }

    func createSale(username: String, mail: String, total: Double, numberOfSeats: Int, seatsReserved: [Seat], functionID: Int) async {
        guard let url = URL(string: "\(BASE_URL)/sales") else { return }
        let formatter = DateFormatter()
        
        var seats : String = ""
        seatsReserved.forEach{seat in
            seats.append("\(seat.row)\(seat.column),")
        }
        let iso8601Formatter = ISO8601DateFormatter()
                iso8601Formatter.formatOptions = [.withInternetDateTime]
        let saleDateString = iso8601Formatter.string(from: Date())
        struct CreateSaleRequest: Encodable {
            let saleDate: String // Or use Date and a custom encoder/formatter
            let username: String
            let mail: String
            let total: Double
            let numberOfSeats: Int
            let seatsReserved: String // String of comma-separated seats
            let qrCode: String
            let functionID: Int
            // Add any other fields your API expects
        }
        let requestBody = CreateSaleRequest(
            saleDate: saleDateString,
            username: username,
            mail: mail,
            total: total,
            numberOfSeats: numberOfSeats,
            seatsReserved: seats, // The comma-separated string
            qrCode:  generateQR(),
            functionID: functionID
        )
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(requestBody)
            let (data, response) = try await URLSession.shared.data(for: request)
            await functionViewModel.reserveSeats(seatsReserved: seatsReserved, functionID: functionID);
            print("Venta enviada correctamente:", response)
        } catch {
            print("Error enviando la venta:", error)
        }
    }


    func generateQR() -> String{
        return "vnjktrjngkjnrt"
    }

    func changeQRtoImage(){

    }
    

    
}
