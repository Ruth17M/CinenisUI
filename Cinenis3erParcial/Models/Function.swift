import Foundation

struct Function : Codable, Identifiable{
    let id: Int?
    let functionDate: Date
    let room: Int
    let availability: String
    let movie: Movie 

    init(functionDate: Date,
         room: Int,
         availability: String,
         movie: Movie) {
        self.functionDate = functionDate
        self.room = room
        self.availability = availability
        self.movie = movie
    }
}