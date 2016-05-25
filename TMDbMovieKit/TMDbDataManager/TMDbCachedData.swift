////
////  TMDbCachedData.swift
////  DiscoverMovies
////
////  Created by Kaira Diagne on 23/05/16.
////  Copyright © 2016 Kaira Diagne. All rights reserved.
////
//
//import Foundation
//
//class TMDbMovieListCache {
//    
//    private(set) var data: TMDbMovieList {
//        didSet {
//            // TMDbDataDidChangeNotification
//        }
//    }
//    
//    let writeQueue = dispatch_queue_create("com.discovermovies.project.write", DISPATCH_QUEUE_SERIAL)
//    
//    var lastUpdated: NSDate = NSDate()
//    
//    var refreshTimer: NSTimeInterval = 300
//    
//    var expireInterval: NSTimeInterval?
//    
//    var needsRefresh: Bool = false
//    
//    var loading: Bool = false
//    
//    var filePath : String {
//        let manager = NSFileManager.defaultManager()
//        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as! NSURL
//        return url.URLByAppendingPathComponent("objectsArray").path!
//    }
//    
//    
//}
//
//// What do we need from this class
//
//    // It holds a data object that needs to conform to NSCoding so it can be archived
//        // It needs to know when it was last updated
//        // It should know when it needs to expire
//        // It let other classes know if it the data is expired and needs a refresh
//        // It should let other classes know when it is loading data
//
//    // Saving   
//        // it should know where to save
//        // Should happen on a background thread we created 
//        // Whenever the data is loaded we need to send a notification
//
//    // Use Every time reloadIfNeeded is called the manager asks this class if the data needs a refresh 
//        // if refresh 
//            // DidStartLoading
//        // If not refresh 
//            // Do nothing
//
//        // If response 
//            // Manager did stop loading
//
//        // If cached data is set did change notification 
//
//
//public class TMDbDataManager {
//    
//    private let cache = TMDbMovieListCache
//    
//    var data: [TMDbMovie]
//        return cache.data.items
//    }
//
//
//    
//    
//    
//
//
//
//
//
//
//}
//
//
//
//
//
//
//
