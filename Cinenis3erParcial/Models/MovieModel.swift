//
//  MovieModel.swift
//  Cinenis3erParcial
//
//  Created by ISSC_411_2024 on 12/06/25.
//

import Foundation

struct MovieModel : Codable, Identifiable {
    var id: Int?
    var title: String
    var genre: String
    var year: Int
    var image: String
    var description: String
    var stars: Int
    var duration: Int
    var classification: String
    var schedule: String
}
