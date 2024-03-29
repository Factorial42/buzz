//
//  PlayerView.swift
//  Buzz
//
//  Created by Lasha Efremidze on 1/31/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import Player

class PlayerView: UIView {
    
    lazy var player: Player = { [unowned self] in
        let player = Player()
        player.playerDelegate = self
        self.insertSubview(player.view, at: 0)
        player.view.constrainToEdges()
        return player
    }()
    
    var shouldPlay: ((Void) -> Bool)?
    
}

// MARK: - PlayerDelegate
extension PlayerView: PlayerDelegate {
    
    func playerReady(_ player: Player) {
        guard shouldPlay?() ?? true else { return }
        player.playFromCurrentTime()
    }
    func playerPlaybackStateDidChange(_ player: Player) {}
    func playerBufferingStateDidChange(_ player: Player) {}
    
}
