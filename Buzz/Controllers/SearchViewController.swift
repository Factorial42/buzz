//
//  SearchViewController.swift
//  Buzz
//
//  Created by Lasha Efremidze on 2/21/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import UIKit
import SpriteKit
import Magnetic

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = "Search"
            searchBar.delegate = self
            searchBar.backgroundColor = .clear
            searchBar.backgroundImage = UIImage()
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(white: 0.9, alpha: 1)
        }
    }
    
    @IBOutlet weak var skView: SKView! {
        didSet {
            _ = scene
        }
    }
    
    lazy var scene: Magnetic = { [unowned self] in
        let scene = Magnetic(size: self.skView.bounds.size)
        self.skView.presentScene(scene)
        return scene
    }()
    
    let results = Dummy.sharedInstance.makeSearchResults(5)
    var filtered = [SearchResultProtocol]() {
        didSet {
            let old = oldValue.filter { value in !filtered.contains { $0.name == value.name } }
            let new = filtered.filter { value in !oldValue.contains { $0.name == value.name } }
            DispatchQueue.main.async { [unowned self] in
                self.reload(old: old, new: new)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filtered = results
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reload(old: [], new: filtered)
    }
    
}

// MARK: - Data
extension SearchViewController {
    
    func reload(old: [SearchResultProtocol], new: [SearchResultProtocol]) {
        scene.children.flatMap { $0 as? MyNode }.forEach { node in
            let remove = old.contains { $0.name == node.object.name }
            if remove {
                node.removeFromParent()
            }
        }
        
        for item in new {
            let node = MyNode.make(title: item.name, image: UIImage(named: UIImage.all.randomItem), radius: 40, color: UIColor.all.randomItem)
            node.object = item
            scene.addChild(node)
        }
    }
    
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
//        let predicate = NSPredicate(format: "name BEGINSWITH[c] %@", searchText)
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
//            self.filtered = searchText.isEmpty ? self.results : self.results.lazy.filter { predicate.evaluate(with: $0) }
            self.filtered = searchText.isEmpty ? self.results : self.results.lazy.filter { $0.name.lowercased().hasPrefix(searchText.lowercased()) }
//            DispatchQueue.main.async { [unowned self] in
//                self.reload()
//            }
        }
    }
    
}

// search
// 1) top
// 2) people
// 3) tags
// 4) places

// get top (?q=paris) => paris hilton, #paris, (Paris, France)
// get people (?q=paris) => paris hilton
// get tags (?q=paris) => #paris
// get places (?q=paris) => (Paris, France)

class MyNode: Node {
    
    var object: SearchResultProtocol!
    
    override func removeFromParent() {
        SKAction.fadeOut(withDuration: 0.2)
        super.removeFromParent()
    }
    
    override class func make(title: String?, image: UIImage?, radius: CGFloat, color: UIColor) -> MyNode {
        let node = MyNode(circleOfRadius: radius)
        node.physicsBody = {
            let body = SKPhysicsBody(circleOfRadius: radius + 2)
            body.allowsRotation = false
            body.friction = 0
            body.linearDamping = 2
            return body
        }()
        node.fillColor = .black
        node.strokeColor = .clear
        _ = node.sprite
        _ = node.title
        node.title = title
        node.image = image
        node.color = color
        return node
    }
    
}
