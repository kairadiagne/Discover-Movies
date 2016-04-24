//
//  String+ToNSDate.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

extension String {
    
    func toDate() -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyy-MM-DD"
        return formatter.dateFromString(self)
    }
    
}
