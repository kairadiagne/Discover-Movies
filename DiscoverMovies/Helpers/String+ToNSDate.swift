//
//  String+ToNSDate.swift
//  Discover
//
//  Created by Kaira Diagne on 22-02-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

extension String {
    
    func toDate() -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd''HH:mm:ss'   '"
        return formatter.dateFromString(self)
    }
    
}
