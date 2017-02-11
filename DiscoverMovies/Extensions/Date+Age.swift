//
//  Date+Age.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation

extension Date {
    
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    
}

