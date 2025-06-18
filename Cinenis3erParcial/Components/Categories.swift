//
//  Categories.swift
//  Cinenis3erParcial
//
//  Created by Ruth Manriquez on 12/06/25.
//

import SwiftUI
import AVKit

struct VideoBackgroundView: NSViewRepresentable {
    let videoName: String

    func makeNSView(context: Context) -> AVPlayerView {
        let playerView = AVPlayerView()
        if let url = Bundle.main.url(forResource: videoName, withExtension: "mov") {
            let player = AVPlayer(url: url)
            player.isMuted = true
            player.play()
            player.actionAtItemEnd = .none

            // Loop
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                player.seek(to: .zero)
                player.play()
            }

            playerView.player = player
        }
        playerView.controlsStyle = .none
        playerView.videoGravity = .resizeAspectFill
        return playerView
    }

    func updateNSView(_ nsView: AVPlayerView, context: Context) {}
}

struct Categories: View {
    let category: String
    let videoName: String
    @StateObject var functionViewModel = FunctionViewModel()
    @Binding var movies : [Movie]

    var body: some View {
        ZStack {
            VideoBackgroundView(videoName: videoName)
                .frame(width: 190, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 20))

            Text(category)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .shadow(radius: 2)
        }
        .frame(width: 190, height: 130)
        .buttonStyle(PlainButtonStyle())
        .onTapGesture {
            Task{
                categoriaSeleccionada = category
                movies = await functionViewModel.loadBoard(date: fechaSeleccionada, genre: category, premiere: false)
            }
        }
    }
}



#Preview {
    ContentView()
}
