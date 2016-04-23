//
//  NSDate+Comparing.swift
//  Discover
//
//  Created by Kaira Diagne on 22-02-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

extension NSDate {
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        var isLess = false
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending {
            isLess = true
        }
        return isLess
    }

}