//
//  SaleModel.swift
//  Cinenis3erParcial
//
//  Created by ISSC_411_2024 on 12/06/25.
//

import Foundation

struct SaleModel : Codable, Identifiable {
    var id: Int?
    var saleDate : Date
    var username : String
    var mail : String
    var total : Double
    var numberOfSeats : Int
    var seatsReserved : String
    var functionID: Int
}
