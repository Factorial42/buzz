//
//  Data.swift
//  Buzz
//
//  Created by Lasha Efremidze on 4/4/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import Foundation

struct Category {
    
    let data = [
        "Social": [
            "Arts": [
                "Art Dealers and Galleries": []
            ],
            "Bars": [
                "Hotel Lounges": []
            ]
        ]
    ]
    
    
    
    
//    Social > Arts > Art Dealers and Galleries
//    
//    Social > Bars > Hotel Lounges
//    Social > Bars > Jazz and Blues Cafes
//    Social > Bars > Sports Bars
//    Social > Bars > Wine Bars
//    Social > Bars
//    Social > Food and Dining > Breweries
//    Businesses and Services > Food and Beverage > Catering
//    Social > Food and Dining > Cafes, Coffee and Tea Houses
//    Social > Food and Dining > Restaurants > Fast Food
//    Social > Food and Dining > Restaurants > Food Trucks
//    Social > Food and Dining > Ice Cream Parlors
//    Social > Food and Dining > Juice Bars and Smoothies
//    Businesses and Services > Food and Beverage
//    Businesses and Services > Food and Beverage > Distribution
//    Social > Food and Dining > Internet Cafes
//    Social > Food and Dining > Restaurants > Burgers
//    Social > Food and Dining > Restaurants > Delis
//    Social > Food and Dining > Restaurants > Diners
//    Social > Food and Dining > Restaurants > American
//    Social > Food and Dining > Restaurants > Asian
//    Social > Food and Dining > Restaurants > Barbecue
//    Social > Food and Dining > Restaurants > Buffets
//    Social > Food and Dining > Restaurants > Chinese
//    Social > Food and Dining > Dessert
//    Social > Food and Dining > Restaurants > French
//    Social > Food and Dining > Restaurants > Indian
//    Social > Food and Dining > Restaurants > International
//    Social > Food and Dining > Restaurants > Italian
//    Social > Food and Dining > Restaurants > Japanese
//    Social > Food and Dining > Restaurants > Korean
//    Social > Food and Dining > Restaurants > Mexican
//    Social > Food and Dining > Restaurants > Middle Eastern
//    Social > Food and Dining > Restaurants
//    Social > Food and Dining > Restaurants > Seafood
//    Social > Food and Dining > Restaurants > Sushi
//    Social > Food and Dining > Restaurants > Thai
//    Social > Food and Dining > Restaurants > Pizza
//    Social > Food and Dining > Restaurants > Steakhouses
//    Social > Food and Dining > Restaurants > Vegan and Vegetarian
//    Social > Wineries and Vineyards
//    
//    Social > Arts > Museums
//    
//    Landmarks > Gardens
//    Landmarks > Historic and Protected Sites
//    Landmarks > Monuments and Memorials
//    
//    Social > Zoos, Aquariums and Wildlife Sanctuaries
//    
//    Landmarks > Natural > Beaches
//    
//    Sports and Recreation > Golf > Golf Courses
//    Sports and Recreation > Gun Ranges
//    
//    Sports and Recreation > Outdoors > Campgrounds and RV Parks
//    Sports and Recreation > Outdoors > Hiking
//    Sports and Recreation > Outdoors > Hot Air Balloons
//    Sports and Recreation > Outdoors > Hunting and Fishing
//    Sports and Recreation > Outdoors > Rock Climbing
//    Sports and Recreation > Outdoors > Skydiving
//    
//    Sports and Recreation > Snow Sports
//    
//    Sports and Recreation > Water Sports > Boating
//    Sports and Recreation > Water Sports > Canoes and Kayaks
//    Sports and Recreation > Water Sports > Rafting
//    Sports and Recreation > Water Sports > Scuba Diving
//    Sports and Recreation > Water Sports > Surfing
//    Sports and Recreation > Water Sports > Swimming
//    
//    Transportation > Transport Hubs > Airports
//    
//    Transportation > Taxi and Car Services > Car and Truck Rentals
//    
//    Transportation > Public Transportation Services
//    
//    Travel > Cruises
//    
//    Travel > Lodging > Bed and Breakfasts
//    Travel > Lodging > Cottages and Cabins
//    Travel > Lodging > Hostels
//    Travel > Lodging > Hotels and Motels
//    Travel > Lodging > Resorts
//    Travel > Lodging > Lodges and Vacation Rentals
//    Travel > Tourist Information and Services
    
}

class Node<T> {
    typealias U = Node<T>
    
    let value: T
    weak var parent: U?
    var children = [U]()
    
    init(_ value: T) {
        self.value = value
    }
    
    func addChild(_ node: U) {
        children.append(node)
        node.parent = self
    }
}

extension Node where T: Hashable {
    
    static func make(_ data: [T: Any?]) -> [Node<T>] {
        return data.map { key, value in
            let node = Node(key)
            if let value = value as? [T: Any?] {
                Node.make(value).forEach {
                    node.addChild($0)
                }
            } else if let value = value as? [T] {
                Node.make(value).forEach {
                    node.addChild($0)
                }
            }
            return node
        }
    }
    
}

extension Node {
    
    static func make(_ data: [T]) -> [Node<T>] {
        return data.map { Node($0) }
    }
    
}
