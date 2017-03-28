//
//  Location.swift
//  Buzz
//
//  Created by Lasha Efremidze on 2/28/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
