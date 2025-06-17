import SwiftUI
import CoreImage.CIFilterBuiltins
import AppKit

@MainActor
class SalesViewModel : ObservableObject {
    let BASE_URL = "https://shark-app-p8ovg.ondigitalocean.app"
    @Published var isSaleLoading = false
    @StateObject var functionViewModel = FunctionViewModel()
    @Published var sale: Sale?
    @Published var saleRecieved: SaleModel?
    private let ciContext = CIContext()
    private let qrFilter = CIFilter.qrCodeGenerator()
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
            var qrCode: String
            let functionID: Int
            // Add any other fields your API expects
        }
        var requestBody = CreateSaleRequest(
            saleDate: saleDateString,
            username: username,
            mail: mail,
            total: total,
            numberOfSeats: numberOfSeats,
            seatsReserved: seats, // The comma-separated string
            qrCode:  "",
            functionID: functionID
        )
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(requestBody)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let createdSale = try JSONDecoder().decode(SaleModel.self, from: data)
            self.saleRecieved = createdSale

            // ← Aquí va tu snippet:
            if let sale = saleRecieved,
            let qrBase64 = generateQR(from: sale) {
                requestBody.qrCode = qrBase64
            }

            // 4) opcionalmente, podrías volver a enviar requestBody para guardar el QR
            //    o llamar otro endpoint que actualice el campo qrCode en tu backend.

            // 5) reservas los asientos
            await functionViewModel.reserveSeats(
                seatsReserved: seatsReserved,
                functionID:    functionID
                )
        } catch {
            print("Error enviando la venta:", error)
        }
    }
    
    
    func generateQR(from sale: SaleModel) -> String? {
        guard let jsonData = try? JSONEncoder().encode(sale),
              let jsonString = String(data: jsonData, encoding: .utf8)
        else { return "" }
        
        let data = Data(jsonString.utf8)
        qrFilter.setValue(data, forKey: "inputMessage")
        
        guard let ciImage = qrFilter.outputImage?
            .transformed(by: CGAffineTransform(scaleX: 10, y: 10)),
              let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent)
        else {
            return ""
        }
        
        let rep = NSBitmapImageRep(cgImage: cgImage)
        guard let pngData = rep.representation(using: .png, properties: [:]) else {
            return ""
        }
        
        return pngData.base64EncodedString()
    }
    
    func changeQRtoImage() -> NSImage? {
        guard let b64 = saleRecieved?.qrCode,
              let data = Data(base64Encoded: b64)
        else { return nil }
        return NSImage(data: data)
    }
}