//
//  CarrouselMainView.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 11/06/25.
//

import SwiftUI
import AppKit

struct CarouselMainView: View {
    let images = ["Image1", "Image2", "Image3", "Image4", "Image5", "Image6"]
    @State private var currentIndex = 0
    @Binding var isDarkImage: Bool
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if !images.isEmpty {
                    Image(images[currentIndex])
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.5), value: currentIndex)
                        .onAppear {
                            updateLuminance()
                        }
                        .onChange(of: currentIndex) { _ in
                            updateLuminance()
                        }
                }

                HStack {
                    Button(action: {
                        withAnimation {
                            currentIndex = (currentIndex - 1 + images.count) % images.count
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.largeTitle)
                            .foregroundStyle(Color("TextoBlanco"))
                            .padding()
                    }
                    .buttonStyle(PlainButtonStyle())

                    Spacer()

                    Button(action: {
                        withAnimation {
                            currentIndex = (currentIndex + 1) % images.count
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.largeTitle)
                            .foregroundStyle(Color("TextoBlanco"))
                            .padding()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 30)
            }
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % images.count
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }

    private func updateLuminance() {
        guard let nsImage = NSImage(named: images[currentIndex]) else {
            isDarkImage = false
            return
        }
        let luminance = nsImage.averageLuminance()
        isDarkImage = luminance < 0.5
    }
}

