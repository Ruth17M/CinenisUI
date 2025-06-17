import Foundation

struct Function : Codable, Identifiable{
    let id: Int?
    let functionDate: String
    let room: Int
    let availability: String
    let movie: Movie
    
    var date: Date? {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ" // <--- Adjust this if your backend format is different!
           formatter.locale = Locale(identifier: "en_US_POSIX") // Ensures consistent parsing
           formatter.timeZone = TimeZone(identifier: "America/Mexico_City") // Apply correct timezone for parsing
           return formatter.date(from: functionDate)
       }

    init(functionDate: Date,
         room: Int,
         availability: String,
         movie: Movie) {
        let formatter = DateFormatter()
        // Set the correct date format based on what your backend sends
        // Example: "yyyy-MM-dd HH:mm:ss" if your string looks like "2023-10-26 15:30:00"
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ" // Adjust this to your actual string format
        formatter.locale = Locale(identifier: "en_US_POSIX") // Recommended for fixed-format dates
        formatter.timeZone = TimeZone(identifier: "America/Mexico_City") // Set appropriate timezone
        self.id = nil
        self.functionDate = formatter.string(from: functionDate)
        self.room = room
        self.availability = availability
        self.movie = movie
    }
}
