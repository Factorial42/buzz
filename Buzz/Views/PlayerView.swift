//
//  PlayerView.swift
//  Buzz
//
//  Created by Lasha Efremidze on 1/31/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import Player
import AVFoundation

class PlayerView: UIView {
    
    lazy var player: Player = { [unowned self] in
        let player = Player()
        player.delegate = self
        self.addSubview(player.view)
        player.view.constrainToEdges()
        return player
    }()
    
    func configure(muted: Bool) {
        try! AVAudioSession.sharedInstance().setCategory(muted ? AVAudioSessionCategoryAmbient : AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        player.fillMode = AVLayerVideoGravityResizeAspectFill
        player.playbackLoops = true
        player.muted = muted
    }
    
}

// MARK: - PlayerDelegate
extension PlayerView: PlayerDelegate {
    
    func playerReady(_ player: Player) {
        player.playFromCurrentTime()
    }
    
}
