//
//  DemoURL.swift
//  Cassini
//
//  Created by Illarionova Violetta on 20/03/2017.
//  Copyright © 2017 Disruptvioletta LLC. All rights reserved.
//

import Foundation

struct DemoURL {
    
    static let stanford = URL(string: "http://stanford.edu/about/images/intro_about.jpg") //scrollView tests
    
    static var NASA: Dictionary<String, URL> = {
        let NASAURLStrings = [
            "Cassini" : "https://www.jpl.nasa.gov/missions/web/cassini.jpg",
            "Earth" : "https://static.pexels.com/photos/2422/sky-earth-galaxy-universe.jpg",
            "Saturn" : "http://kvant.space/sites/default/files/maxresdefault_0.jpg" ]
        var urls = Dictionary<String,URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
        
    }()
    
}
