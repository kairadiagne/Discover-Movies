//
//  NSDate+ToString.swift
//  
//
//  Created by Kaira Diagne on 23-04-16.
//
//

import Foundation

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
}
