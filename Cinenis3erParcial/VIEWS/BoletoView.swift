//
//  BoletoView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 15/06/25.
//

import SwiftUI

struct BoletoView: View {
    var body: some View {
        VStack {
                    Text("Spider-Man: No Way Home")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    AsyncImage(url: URL(string: "https://www.informador.mx/export/sites/elinformador/img/2021/11/15/fepvsn_wqasaq-i.jpg_1090526674.jpg"))
                    { image in
                        image.image?
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 180)
                            .cornerRadius(10)
                            .clipped()
                    }
                    
                    HStack{
                        Image(systemName: "calendar")
                        Text("5 Feb")
                        
                        Image(systemName: "clock")
                        Text("6:00 PM")
                        
                        Image(systemName: "hourglass")
                        Text("150 min")
                    }
                    .padding()
                    
                    HStack{
                        VStack{
                            Text("Room")
                                .font(.subheadline)
                                .foregroundColor(Color.white)
                            Text("1")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        VStack{
                            Text("Room")
                                .font(.subheadline)
                                .foregroundColor(Color.white)
                            Text("5")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        VStack{
                            Text("Room")
                                .font(.subheadline)
                                .foregroundColor(Color.white)
                            Text("A")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                       
                       
                    }
                    .padding()
                    .cornerRadius(10)
                    .frame(maxWidth: 250)
                        
                    
                    
                    
                }
                .frame(height: 400)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(15)
                .shadow(radius: 10)
    }
}
