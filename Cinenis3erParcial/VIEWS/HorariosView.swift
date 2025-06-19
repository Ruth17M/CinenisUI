import SwiftUI
import Foundation // Necesario para Date y DateFormatter

struct HorariosView: View {
    let movieID: Int// This should be passed in from MovieView
    @StateObject var functionViewModel = FunctionViewModel()
    @Binding var funciones : [Function] 

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
                                .font(.system(size: 20, weight: .light))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .overlay(
                                    Capsule()
                                        .stroke(Color("MenuTexto"), lineWidth: 1.5)  // Cambia Color.blue por el color que prefieras
                                )
                                // La condición ahora se basa en 'formattedTime'
                               // .foregroundColor(.white)
                                
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }.onAppear{
            Task{
                funciones = await functionViewModel.loadFunctionsByMovie(movieID: movieID, date: fechaSeleccionada)
            }
        }
    }

    private func timeString(from dateString: String) -> String {
        var horario = String(dateString.dropLast(4))
        horario = String(horario.dropFirst(11))
        return horario
    }
}

#Preview {
    ContentView()
}
