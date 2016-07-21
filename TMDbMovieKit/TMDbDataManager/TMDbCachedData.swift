//
//  TMDbCachedData.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 21-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

class TMDbCachedData<ModelType> {
    
    // MARK: Properties
    
    private(set) var data: ModelType? {
        didSet {
            self.lastUpdate = NSDate()
        }
    }
    
    var needsRefresh = false {
        if let lastUpdate = lastUpdate {
            return true
        }
        
        return abs(lastUpdate.timeIntervalSinceNow) > refreshTimout ? true : false
    }
    
    private var lastUpdate: NSDate?
    
    // Specifies a time interval in seconds
    private var refreshTimout: NSTimeInterval = 300
    
    // MARK: Initializers
    
    init(refreshTimeout: NSTimeInterval = nil) {
        self.refreshTimout = refreshTimout
    }
    
    // MARK: Add Remove Data
    
    func update(withData data: ModelType) {
        data = data
        lastUpdate = NSDate()
    }
    
    func clear() {
        self.data = nil
        self.lastUpdate = nil
    }
    
    // MARK: Disk Cache
    
//    func saveToDisk() {
//        
//    }
//    
//    func loadFromDisk() {
//        
//    }

}

