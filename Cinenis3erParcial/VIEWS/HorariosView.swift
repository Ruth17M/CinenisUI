import SwiftUI
import Foundation // Necesario para Date y DateFormatter

struct HorariosView: View {
    let funciones: [Function] // This should be passed in from MovieView

    // No necesitamos 'var hora' como propiedad de HorariosView
    // La hora se calculará para cada 'funcion' individualmente

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(funciones) { funcion in
                        let formattedTime = self.timeString(from: funcion.functionDate)

                        NavigationLink(destination: MovieView(function: funcion)) {
                            Text(formattedTime) // Usar la hora formateada de esta función
                                .font(.system(size: 15, weight: .light))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                // La condición ahora se basa en 'formattedTime'
                                .foregroundColor(formattedTime == "20:00" ? .black : .white)
                                .background(formattedTime == "20:00" ? Color("ColorAmarillo") : Color.gray.opacity(0.3))
                                .clipShape(Capsule())
                        }
                    }
                }
            }
        }
    }

    private func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "es_MX")
        return formatter.string(from: date)
    }
}

