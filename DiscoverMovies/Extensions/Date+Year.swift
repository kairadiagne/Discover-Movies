//
//  Date+Year.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

extension Date {
    
    func year() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year], from: self)
        return components.year!
    }
}
