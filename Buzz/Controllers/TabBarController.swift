//
//  TabBarController.swift
//  Buzz
//
//  Created by Lasha Efremidze on 1/31/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .black
        //self.tabBar.unselectedItemTintColor = .black
        
        let items = [Item(viewController: VideoListViewController.instantiate(), image: UIImage(named: "home"), selectedImage: UIImage(named: "home-filled")), Item(viewController: VideoListViewController.instantiate(), image: UIImage(named: "search"), selectedImage: UIImage(named: "search-filled")), Item(viewController: VideoListViewController.instantiate(), image: UIImage(named: "camera"), selectedImage: UIImage(named: "camera-filled")), Item(viewController: VideoListViewController.instantiate(), image: UIImage(named: "user"), selectedImage: UIImage(named: "user-filled"))]
        self.viewControllers = items.map { $0.viewController }
        items.forEach {
            let item = UITabBarItem(title: nil, image: $0.image?.withRenderingMode(.alwaysOriginal), selectedImage: $0.selectedImage?.withRenderingMode(.alwaysOriginal))
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            $0.viewController.tabBarItem = item
        }
    }
    
}

private struct Item {
    let viewController: UIViewController
    let image: UIImage?
    let selectedImage: UIImage?
}
