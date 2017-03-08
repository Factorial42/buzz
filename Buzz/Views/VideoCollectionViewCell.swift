//
//  VideoCollectionViewCell.swift
//  Buzz
//
//  Created by Lasha Efremidze on 2/1/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import UIKit
import AVFoundation
import AlamofireImage
import GradientView

class VideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var playerView: PlayerView! {
        didSet {
            playerView.backgroundColor = .black
            playerView.player.fillMode = AVLayerVideoGravityResizeAspectFill
            playerView.player.playbackLoops = true
            playerView.player.muted = false
        }
    }
    @IBOutlet weak var gradientView: GradientView! {
        didSet {
            gradientView.backgroundColor = .clear
            gradientView.colors = [UIColor(white: 0, alpha: 0.2), UIColor(white: 0, alpha: 0.5)]
        }
    }
    @IBOutlet weak var textLabel: UILabel! {
        didSet {
            textLabel.font = .boldSystemFont(ofSize: 14)
            textLabel.textColor = .white
        }
    }
    @IBOutlet weak var detailTextLabel: UILabel! {
        didSet {
            detailTextLabel.font = .systemFont(ofSize: 14)
            detailTextLabel.textColor = .white
        }
    }
    @IBOutlet weak var userView: VideoCollectionViewCellUserView!
    
    func configure(with video: Video) {
        playerView.player.url = video.url
        textLabel.text = video.caption
        detailTextLabel.text = video.location.name
        userView.imageView.af_setImage(withURL: video.user.profilePicture)
        userView.textLabel.text = video.user.username
    }
    
}

class VideoCollectionViewCellUserView: UIStackView {
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = self.bounds.height / 2
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.borderWidth = 1
            imageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var textLabel: UILabel! {
        didSet {
            textLabel.font = .systemFont(ofSize: 14)
            textLabel.textColor = .white
        }
    }

}
