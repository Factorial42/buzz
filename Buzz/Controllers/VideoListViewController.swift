//
//  VideoListViewController.swift
//  Buzz
//
//  Created by Lasha Efremidze on 1/31/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var videos: [Video]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

// MARK: - UITableViewDataSource
extension VideoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

// MARK: - UITableViewDelegate
extension VideoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
}
