//
//  NSDate+Year.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

extension NSDate {
    
    func year() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year], fromDate: self)
        return components.year
    }
    
}
