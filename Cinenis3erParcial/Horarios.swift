//
//  Horarios.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 14/06/25.
//
import SwiftUI

struct Horarios: View {
    let hora : String
    var body: some View {
        Text(hora)
            .font(.system(size: 20, weight: .light))
            .padding(.vertical, 9)
            .padding(.horizontal, 19)
            .overlay(
                Capsule()
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}
