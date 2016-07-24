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
    
    private(set) var data: ModelType?
    
    var needsRefresh: Bool = true 
    
//    {
//        if let lastUpdate = lastUpdate {
//            return true
//        }
//        return true
////        return abs(lastUpdate.timeIntervalSinceNow) > refreshTimout ? true : false
//    }
    
    private var lastUpdate: NSDate?
    
    private var refreshTimeOut: NSTimeInterval! // Specifies a time interval in seconds
    
    // MARK: Initializers
    
    init(refreshTimeOut timeOut: NSTimeInterval = 300) {
        self.refreshTimeOut = timeOut
    }
    
    // MARK: Clear Cache
    
    func addData(data: ModelType) {
        self.data = data
        self.lastUpdate = NSDate()
    }
    
    func clear() {
        self.data = nil
        self.lastUpdate = nil
    }

}

