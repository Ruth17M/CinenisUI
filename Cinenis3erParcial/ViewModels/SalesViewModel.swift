import SwiftUI

@MainActor
class SalesViewModel : ObservableObject {
    let BASE_URL = "https://seahorse-app-yy79u.ondigitalocean.app/"
    @Published var isSaleLoading = false
    @Published var sale: Sale ?

    init(){
        Task {

        }
    }

    func loadSale(saleId: Int) async {
        guard let url = URL(string: "\(BASE_URL)/sales?id=\(saleId)") else { return }
        do{ 
            isSaleLoading = true
            let (data, _) = try await URLSession.shared.data(from: url!)
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
        await reserveSeats(seatsReserved: seatsReserved, functionID: functionID);
        var qr = await generateQR()
        var seats : String = ""
        seatsReserved.forEach{seat in
            seats.append("\(seat.row)\(seat.column),")
        }
        var body=[
            dateFormatter.string(from: Date()),
            username: username,
            mail: mail,
            total: total,
            numberOfSeats: numberOfSeats,
            seatsReserved: seats,
            qrCode: qr,
            functionID: functionID
        ]
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(body)
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