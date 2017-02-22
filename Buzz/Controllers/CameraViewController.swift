//
//  CameraViewController.swift
//  Buzz
//
//  Created by Lasha Efremidze on 2/21/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import UIKit
import HBRecorder
import AVKit

class CameraViewController: UIViewController {
    
    lazy var recorder: HBRecorder = { [unowned self] in
        let storyboard = UIStoryboard(name: "HBRecorder.bundle/HBRecorder", bundle: Bundle(for: HBRecorder.self))
        let recorder = storyboard.instantiateViewController(withIdentifier: "HBRecorder") as! HBRecorder
        recorder.delegate = self
        recorder.maxRecordDuration = 60 * 2
        self.add(recorder)
        recorder.view.constrainToEdges()
        return recorder
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _ = recorder
    }
    
}

extension CameraViewController: HBRecorderProtocol {
    
    func recorder(_ recorder: HBRecorder!, didFinishPickingMediaWith videoUrl: URL!) {
        let player = AVPlayer(url: videoUrl)
        let viewController = AVPlayerViewController()
        viewController.player = player
        self.present(viewController, animated: true, completion: nil)
        viewController.view.frame = self.view.frame
        player.play()
        
        self.recorder.remove()
        
        let storyboard = UIStoryboard(name: "HBRecorder.bundle/HBRecorder", bundle: Bundle(for: HBRecorder.self))
        self.recorder = storyboard.instantiateViewController(withIdentifier: "HBRecorder") as! HBRecorder
        self.recorder.delegate = self
        self.recorder.maxRecordDuration = 10
        self.add(self.recorder)
        self.recorder.view.constrainToEdges()
    }
    
    func recorderDidCancel(_ recorder: HBRecorder!) {
        
    }
    
}
