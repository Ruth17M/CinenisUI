//
//  FunctionModel.swift
//  Cinenis3erParcial
//
//  Created by ISSC_411_2024 on 12/06/25.
//

import Foundation

struct FunctionModel : Codable, Identifiable {
    let id: Int?
    let functionDate: Date
    let room: Int
    let availability: String
    let movie: MovieModel   
}
