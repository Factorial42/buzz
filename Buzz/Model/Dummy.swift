//
//  Dummy.swift
//  Buzz
//
//  Created by Lasha Efremidze on 2/1/17.
//  Copyright © 2017 Factorial42. All rights reserved.
//

import Foundation
import Fakery
import SwifterSwift

struct Dummy {
    
    static let sharedInstance = Dummy()
    
    let faker = Faker()
    
    func makeVideos() -> [Video] {
        return (0...5).map { _ in makeVideo() }
    }
    
    func makeVideo() -> Video {
        let url = ["https://v.cdn.vine.co/r/videos/AA3C120C521177175800441692160_38f2cbd1ffb.1.5.13763579289575020226.mp4", "http://techslides.com/demos/sample-videos/small.mp4"].randomItem.url!
        return Video(id: faker.number.randomInt().description, caption: faker.company.name(), location: faker.address.city() + ", " + faker.address.country(), url: url, user: makeUser())
    }
    
    func makeUser() -> User {
        let url = "https://unsplash.it/100?random".url!
        return User(id: faker.number.randomInt().description, username: faker.internet.username(), fullName: faker.name.name(), bio: faker.lorem.sentence(), profilePicture: url)
    }
    
}
