import SwiftUI

@MainActor
class FunctionViewModel : ObservableObject {

    let BASE_URL = "https://orca-app-dk9lb.ondigitalocean.app"
    @Published var areFunctionsLoading = false 
    @Published var functionList: [Function] = []
    @Published var isBoardLoading = false 
    @Published var movieList: [Movie] = []
    @Published var areSeatsLoading = false 
    @Published var seats: [[Seat]] = []

    init() {
        Task{
            var todaysDate = Date()
            await loadBoard(date: todaysDate, genre: "any", premiere: false)
        }
    }


    func loadBoard(date: Date, genre: String, premiere: Bool) async -> [Movie]{
        //obtener las peliculas que tienen funcion segun los parametros
        guard let url = URL(string: "\(BASE_URL)/functions/moviesFiltered") else { return [] }
        let calendar = Calendar.current
        guard let mexicoCityTimeZone = TimeZone(identifier: "America/Mexico_City") else {
            fatalError("No se pudo encontrar la zona horaria de la Ciudad de México.")
        }
        let dateComponents = calendar.dateComponents(in: mexicoCityTimeZone, from: date)
        guard let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day else {
            print("No se pudieron obtener los componentes de la fecha")
            return []
        }
        let body: [String: Any] = [
            "year": year,
            "month": month,
            "day": day,
            "genre": genre,
            "premiere": premiere
        ]

        do {
            areFunctionsLoading = true
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

            let (data, _) = try await URLSession.shared.data(for: request)
            let moviesDecoded = try JSONDecoder().decode([Movie].self, from: data)
            movieList = moviesDecoded
            return movieList
            isBoardLoading = false
        } catch {
            print("Error cargando las carteleras", error)
            isBoardLoading = false
            return []
        }

        
    }
    func loadFunctionsByMovie(movieID: Int, date: Date) async -> [Function]{
        //Obtener las funciones de la pelicula por dia e id de la pelicula
        guard let url = URL(string: "\(BASE_URL)/functions/movieFunctions") else { return [] }
        let calendar = Calendar.current
        guard let mexicoCityTimeZone = TimeZone(identifier: "America/Mexico_City") else {
            fatalError("No se pudo encontrar la zona horaria de la Ciudad de México.")
        }
        let dateComponents = calendar.dateComponents(in: mexicoCityTimeZone, from: date)
        guard let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day else {
            print("No se pudieron obtener los componentes de la fecha")
            return []
        }
        let body: [String: Any] = [
            "year": year,
            "month": month,
            "day": day,
            "movieID": movieID,
            "premiere": false
        ]

        do {
            areFunctionsLoading = true
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

            let (data, _) = try await URLSession.shared.data(for: request)
            let functionsDecoded = try JSONDecoder().decode([Function].self, from: data)
            functionList = functionsDecoded
            areFunctionsLoading = false
            return functionList
        } catch {
            print("Error cargando las funciones", error)
            areFunctionsLoading = false
            return []
        }
    }

    func loadSeats(functionID: Int) async -> [[Seat]]{
        let url = URL(string: "\(BASE_URL)/functions/\(functionID)")
        do{
            areSeatsLoading = true
            seats = [[]]
            let (data, _) = try await URLSession.shared.data(from: url!)
            let functionDecode = try JSONDecoder().decode(Function.self, from: data)
            var availability = functionDecode.availability
            createArraySeats(availabityString: availability)
            return seats
            areSeatsLoading = false
        }
        catch{
            print("Error cargando la venta", error)
            areSeatsLoading = false
            return [[]]
        }
    }

    func createArraySeats(availabityString: String){
        var rows = ["A", "B", "C", "D", "E", "F", "G", "H"]
        let takenSet: Set<String> = Set(availabityString.split(separator: ",").map { String($0) })
        for i in 0..<rows.count { 
            var seatRow: [Seat] = [] 
            for j in 1...10 {
                let actualRow = rows[i]
                let seatId = "\(actualRow)\(j)"
                let isAvailable = !takenSet.contains(seatId)
                let newSeat = Seat(row: actualRow, column: j)
                seatRow.append(newSeat)
            }
            seats.append(seatRow)
        }
    }

    func reserveSeats(seatsReserved: [Seat], functionID: Int) async {
        guard let url = URL(string: "\(BASE_URL)/functions/updateAvailability") else { return }
        var availability : String = ""
        seatsReserved.forEach{ seat in
            availability.append("\(seat.row)\(seat.column),")
        }
        let body: [String: Any] = [
            "id": functionID,
            "availability": availability
        ]
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            
            let (data, response) = try await URLSession.shared.data(for: request)
            // Maneja la respuesta aquí si lo necesitas
            print("Respuesta:", response)
        } catch {
            print("Error reservando asientos:", error)
        }
    }
}
