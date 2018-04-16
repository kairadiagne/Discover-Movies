//
//  Dictionary+merge.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 28-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func merge(_ dict: [Key: Value]) -> [Key: Value] {
        var mutableCopy = self
        for (key, value) in dict {
            // If both dictionaries have a value for same key, the value of the other dictionary is used.
            mutableCopy[key] = value
        }
        return mutableCopy
    }
}
