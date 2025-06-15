import SwiftUI

@MainActor
class FunctionViewModel : ObservableObject {

    let BASE_URL = "https://seahorse-app-yy79u.ondigitalocean.app/"
    @Published var areFunctionsLoading = false 
    @Published var functionList: [Function] = []
    @Published var isBoardLoading = false 
    @Published var movieList: [Movie] = []
    @Published var areSeatsLoading = false 
    @Published var functionSeats: Function
    @Published var seats: [[Seat]] = []

    init() {
        Task{
            loadBoard(date: Date(), genre: "any", premiere: false)
        }
    }


    func loadBoard(date: Date, genre: String, premiere: Bool) async {
        guard let url = URL(string: "\(BASE_URL)/function/moviesFiltered") else { return }
        let calendar = Calendar.current
        guard let mexicoCityTimeZone = TimeZone(identifier: "America/Mexico_City") else {
            fatalError("No se pudo encontrar la zona horaria de la Ciudad de México.")
        }
        let dateComponents = calendar.dateComponents(in: mexicoCityTimeZone, from: date)
        guard let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day else {
            print("No se pudieron obtener los componentes de la fecha")
            return
        }
        let body: [String: Any] = [
            "year": year,
            "month": month,
            "day": day,
            "genre": genre,
            "premiere": premiere
        ]

        do {
            isFunctionLoading = true
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

            let (data, _) = try await URLSession.shared.data(for: request)
            let moviesDecoded = try JSONDecoder().decode([Movie].self, from: data)
            movieList = moviesDecoded
            isBoardLoading = false
        } catch {
            print("Error cargando las carteleras", error)
            isBoardLoading = false
        }

        
    }
    func loadFunctionsByMovie(movieID: Int, date: Date){
        guard let url = URL(string: "\(BASE_URL)/function/movieFunctions") else { return }
        let calendar = Calendar.current
        guard let mexicoCityTimeZone = TimeZone(identifier: "America/Mexico_City") else {
            fatalError("No se pudo encontrar la zona horaria de la Ciudad de México.")
        }
        let dateComponents = calendar.dateComponents(in: mexicoCityTimeZone, from: date)
        guard let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day else {
            print("No se pudieron obtener los componentes de la fecha")
            return
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
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

            let (data, _) = try await URLSession.shared.data(for: request)
            let functionsDecoded = try JSONDecoder().decode([Movie].self, from: data)
            functionList = moviesDecoded
            areFunctionsLoading = false
        } catch {
            print("Error cargando las funciones", error)
            areFunctionsLoading = false
        }
    }

    func loadSeats(functionID: Int){
        let url = URL(string: "\(BASE_URL)/functions?byId=\(functionId)")
        do{ 
            areSeatsLoading = true
            let (data, _) = try await URLSession.shared.data(from: url!)
            let functionDecode = try JSONDecoder().decode(FunctionModel.self, from: data)
            functionSeats = functionDecoded
            createArraySeats(availabityString: functionSeats.availability)
            areSeatsLoading = false
        }
        catch{
            print("Error cargando la venta", error)
            isSaleLoading = false
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
                let isAvailable = !takeSet.contains(seatId)
                let newSeat = Seat(row: ctualRow, column: j, available: isAvailable)
                seatRow.append(newSeat)
            }
            seats.append(seatRow)
        }
    }
}