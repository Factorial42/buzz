//
//  ViewController.swift
//  Buzz
//
//  Created by Lasha Efremidze on 4/4/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var _isVisible: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _isVisible = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        _isVisible = false
    }
    
}
