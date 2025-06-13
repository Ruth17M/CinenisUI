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
        if let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
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

    var body: some View {
        ZStack {
            VideoBackgroundView(videoName: videoName)
                .frame(width: 180, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))

            Text(category)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(radius: 2)
        }
        .frame(width: 180, height: 100)
        .buttonStyle(PlainButtonStyle())
    }
}


#Preview {
    ContentView()
}
