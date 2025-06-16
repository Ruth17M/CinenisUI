//
//  Movie.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 11/06/25.
//

import SwiftUI

struct Movie : Codable, Identifiable{
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

    init(title: String,
         genre: String,
         year: Int,
         image: String,
         description: String,
         stars: Int,
         duration: Int,
         classification: String,
         schedule: String) {
        self.title = title
        self.genre = genre
        self.year = year
        self.image = image
        self.description = description
        self.stars = stars
        self.duration = duration
        self.classification = classification
        self.schedule = schedule
    }  
}