//
//  VideoListViewController.swift
//  Buzz
//
//  Created by Lasha Efremidze on 1/31/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import UIKit

class VideoListViewController: ViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var videos: [Video]!
    let videos = Dummy.sharedInstance.makeVideos(5)
    
    override var _isVisible: Bool {
        didSet {
            collectionView.visibleCells.flatMap { $0 as? VideoCollectionViewCell }.forEach {
                if _isVisible {
                    $0.playerView.player.playFromCurrentTime()
                } else {
                    $0.playerView.player.pause()
                }
            }
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension VideoListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VideoCollectionViewCell.self), for: indexPath) as! VideoCollectionViewCell
        cell.configure(with: videos[indexPath.item])
        cell.playerView.shouldPlay = { [unowned self] in self._isVisible }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension VideoListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? VideoCollectionViewCell)?.playerView.player.playFromBeginning()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? VideoCollectionViewCell)?.playerView.player.pause()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension VideoListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
}
