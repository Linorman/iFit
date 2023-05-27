//
//  AudioManager.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/10.
//

import Foundation
import SwiftUI
import AVFoundation

class AudioManager: ObservableObject {
    var player: AVAudioPlayer?
    
    init() {}
    
    func playBellSound() {
        guard let url = Bundle.main.url(forResource: "bell.mp3", withExtension: nil) else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
