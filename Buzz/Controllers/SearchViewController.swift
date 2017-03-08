//
//  SearchViewController.swift
//  Buzz
//
//  Created by Lasha Efremidze on 2/21/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import UIKit
import SpriteKit

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
    
    let operationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    let results = Dummy.sharedInstance.makeSearchResults(5)
    
    var filteredResults = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
//        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
//            let predicate = NSPredicate(format: "self BEGINSWITH[c] %@", searchText)
//            self.results = searchText.isEmpty ? self.users : self.users.lazy.filter { predicate.evaluate(with: $0) }
//            DispatchQueue.main.async {
//                
//            }
//        }
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
