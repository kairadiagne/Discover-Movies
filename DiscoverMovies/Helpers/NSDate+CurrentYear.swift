//
//  NSDate+CurrentYear.swift
//  Discover
//
//  Created by Kaira Diagne on 21-02-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

extension NSDate {
    
    var currentYear: Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Month, .Year], fromDate: self)
        return components.year
    }
    
}

