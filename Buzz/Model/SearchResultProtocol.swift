//
//  SearchResultProtocol.swift
//  Buzz
//
//  Created by Lasha Efremidze on 3/8/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import Foundation

protocol SearchResultProtocol {
    var name: String { get }
}

extension Location: SearchResultProtocol {}

extension Tag: SearchResultProtocol {}

extension User: SearchResultProtocol {
    var name: String {
        return fullName
    }
}
