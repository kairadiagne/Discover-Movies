//
//  NSDate+ToString.swift
//  
//
//  Created by Kaira Diagne on 23-04-16.
//
//

import Foundation

extension NSDate {
    
    func toString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .NoStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        return formatter.stringFromDate(self)
    }
}