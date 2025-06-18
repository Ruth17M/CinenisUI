
import Foundation

struct Sale : Codable, Identifiable {
    var id: Int?
    var saleDate : Date
    var username : String
    var mail : String
    var total : Double
    var numberOfSeats : Int
    var seatsReserved : String
    var functionID: Int

     init(saleDate: Date,
         username: String,
         mail: String,
         total: Double,
         numberOfSeats: Int,
         seatsReserved: String,
         functionID: Int) {
        self.saleDate = saleDate
        self.username = username
        self.mail = mail
        self.total = total
        self.numberOfSeats = numberOfSeats
        self.seatsReserved = seatsReserved
        self.functionID = functionID
    }

}

struct SaleModel : Codable, Identifiable{
    var id: Int?
    var saleDate : Date
    var username : String
    var mail : String
    var total : Double
    var numberOfSeats : Int
    var seatsReserved : String
    var function: Function
    var qrCode: String?

}
