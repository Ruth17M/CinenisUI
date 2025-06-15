//
//  HorariosView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 15/06/25.
//


import SwiftUI

struct HorariosView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
        
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(["10:00", "12:30", "15:00", "17:30", "20:00", "22:30"], id: \.self) { hora in
                        Text(hora)
                            .font(.system(size: 15, weight: .light))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .foregroundColor(hora == "20:00" ? .black : .white)
                            .background(hora == "20:00" ? Color("ColorAmarillo") : Color.gray.opacity(0.3))
                            .clipShape(Capsule())
                    }
                }
            }
        }

    }
}
