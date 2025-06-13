//
//  Categories.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 12/06/25.
//

import SwiftUI

struct Categories: View {
    let categories: String
    var body: some View {
        Button {
            print("Hello, World!")
        } label: {
            Text(categories)
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
            
            
            
        }
        .frame(width: 180, height: 100)
        .buttonStyle(PlainButtonStyle())
        .background(Color("ColorNegro"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ContentView()
}
