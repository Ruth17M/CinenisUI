//
//  ModalRegistro.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 17/06/25.
//

import SwiftUI


public struct ModalRegistro: View {
    @State private var username: String = ""
    @State private var mail: String = ""
    var cantidadBoletos : Int
    var asientosSeleccionados : [Seat]
    var funcionSeleccionada : Function

    public var body: some View {
        
        ZStack {
            
            // Fondo imagen estática con gradiente
            Image("teatro_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.black.opacity(0.6), .black]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
            VStack(spacing: 20) {
                
                // Título arriba
                Text("Ingresa tus datos")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 250)
                
                
                
                // Rectángulo vertical con los campos y botón
                VStack(spacing: 16) {
                    
                    // Icono debajo del título
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color("ColorAmarillo"))
                    
                    
                    TextField("Username", text: $username)
                        .textFieldStyle(.plain)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    TextField("Email", text: $mail)
                        .textFieldStyle(.plain)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    

               
                       /* BoletoView(username: "estatico", mail: String"estatico", total: total *80, cantidadBoletos: , asientosSeleccionados: <#[Seat]#>,
                        funcionSeleccionada: <#Function#>) */
                       
                    NavigationLink(destination: BoletoView(username: username, mail: mail, total: Double(cantidadBoletos)*80.00, cantidadBoletos: cantidadBoletos, asientosSeleccionados: asientosSeleccionados, funcionSeleccionada: funcionSeleccionada)) {
                            Text("Enviar")
                                .padding()
                                .frame(maxWidth: 200)
                                .background(Color("ColorAmarillo"))
                               // .foregroundColor(Color("ColorAmarillo"))
                                .cornerRadius(10)
                                .buttonStyle(PlainButtonStyle())
                        }
                        .buttonStyle(PlainButtonStyle())

                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.30))
                )
                .padding(.horizontal, 40)
                
                
                HStack{
                    NavigationLink(destination: ContentView()){
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding()
                            .foregroundColor(Color("TextoBlanco"))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .frame(maxWidth: 400, maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // .multilineTextAlignment(.center)
        
        
    }
    
    
}
