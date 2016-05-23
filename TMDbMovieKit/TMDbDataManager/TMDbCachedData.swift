//
//  TMDbCachedData.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

class TMDbCachedData<Item: NSCoding> {
    
    private(set) var data: Item {
        didSet {
            
        }
    }
    
    let writeQueue = dispatch_queue_create("com.discovermovies.project.write", DISPATCH_QUEUE_SERIAL)
    
    var lastUpdated: NSDate = NSDate()
    
    var refreshTimer: NSTimeInterval = 300
    
    var expireInterval: NSTimeInterval? // This is the interval with which we can calculate if the data needs a refresh
    
    var needsRefresh: Bool = false
    
    var loading: Bool = false
    
    var filePath : String {
        let manager = NSFileManager.defaultManager()
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as! NSURL
        return url.URLByAppendingPathComponent("objectsArray").path!
    }
    
    
}

