//
//  Movie.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 11/06/25.
//

import SwiftUI

struct Movie : Content{
    let id: Int?
    let functionDate: Date
    let room: Int
    let availability: String
    let movie: Movie 

    init(function: Function) throws {
        self.id = function.id
        self.functionDate = function.functionDate
        self.room = function.room
        self.availability = function.availability
        self.movie = function.movie
    }   
}