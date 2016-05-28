////
////  TopListManager.swift
////  DiscoverMovies
////
////  Created by Kaira Diagne on 26/05/16.
////  Copyright © 2016 Kaira Diagne. All rights reserved.
////
//
//import Foundation
//import Alamofire
//
//public struct TMDbDataManagerNotification {
//    static let change = "TMDbDataManagerNotification.change"
//    static let startLoading = "TMDbDataManagerNotification.startLoading"
//    static let stopLoading = "TMDbDataManagerNotification.stopLoading"
//    static let error = "TMDbDataManagerNotification.error"
//}
//
//public class TMDbTopListDataManager {
//    
//    private let queue = dispatch_queue_create("com.discoverMovies.app.cache", DISPATCH_QUEUE_SERIAL)
//    
//    private let popularMovieCache: TMDbCachedData<TMDbList<TMDbMovie>>
//    private let topratedMovieCache: TMDbCachedData<TMDbList<TMDbMovie>>
//    private let upcomingMovieCache: TMDbCachedData<TMDbList<TMDbMovie>>
//    private let nowPlayingCache: TMDbCachedData<TMDbList<TMDbMovie>>
//    
//    public var data: [TMDbMovie]? {
//        switch currentTopList {
//        case .Popular:
//            return popularMovieCache.data.i
//        case .TopRated:
//        case .NowPlaying:
//        case .Upcoming:
//        }
//    }
//    
//    var client = TMDbMovieClient()
//        
//    var currentTopList: TMDbToplist
//    
//    private var isLoading = false  {
//        didSet {
//            if isLoading {
//                sendLoadingNotification()
//            } else {
//                sendLoadingNotification()
//            }
//        }
//    }
//    
//    // Error handeling check voor een status code between 400 and 500 then check the error message
//    // 401 needs to be hanled seperately
//    
//    // MARK: - Initialization 
//    
//    init(topList: TMDbToplist? = nil, accountList: TMDbAccountList? = nil) {
//          self.loadCachedData()
//        
//       
//           self.currentTopList = topList
//        }
//
//        if let accountList = accountList {
//           self.accountList = accountList
//        }
//        
//        self.popularMovieCache // initWithidentifier
//        self.topratedMovieCache // initWithidentifier
//        self.upcomingMovieCache // initWithidentifier
//        self.nowPlayingCache // initWithidentifier
//    }
//        
//    public convenience init(topList: TMDbToplist) { // You should either init as a toplist manageror as a account list manager
//        self.init(topList)
//    }
//        
//    public convenience init(accountList: TMDbaccountList) {
//        self.init(accountList: accountList)
//    }
//    
//    deinit {
//       cachedData()
//    }
//    
//    // MARK: - Fetching AccountList
//    
//    func reloadTopIfNeeded(topList: TMDbToplist? = nil) {
//    
//    }
//    
//    func loadMore() {
//
//    }
//    
//    // MARK: - Archiving
//    
//    func cacheData() {
//        dispatch_async(queue) {
//            
//        }
//    }
//
//    func loadCachedData() {
//        dispatch_async(queue) { 
//            
//        }
//    }
//    
//    func unarchiveData() {
//        //  NSKeyedArchiver
//    }
//    
//    // MARK: - Notifications 
//    
//    func sendDidChangeNotification() {
//        let notificationCenter  = NSNotificationCenter.defaultCenter()
//        notificationCenter.postNotificationName(TMDbDataManagerNotification.change, object: self)
//    }
//    
//    func sendLoadingNotification() {
//        let notificationCenter  = NSNotificationCenter.defaultCenter()
//        notificationCenter.postNotificationName(TMDbDataManagerNotification.startLoading, object: self)
//    }
//    
//    func sendStopLoadingNotification() {
//        // Dispatch after
//        let notificationCenter  = NSNotificationCenter.defaultCenter()
//        notificationCenter.postNotificationName(TMDbDataManagerNotification.stopLoading, object: self)
//    }
//    
//    func sendErrorNotification(error: NSError) {
//        let notificationCenter  = NSNotificationCenter.defaultCenter()
//        notificationCenter.postNotificationName(TMDbDataManagerNotification.error, object: self, userInfo: ["error": error])
//    }
//
//}
//    
//
//
//    // MARK: - Fetching
//    
//        // ReloadTopIfNeeded
//            // If cached data needs refresh
//                // Fetch
//    
//            // If force online 
//                // fetch
//    
//    
//        // LoadMore
//            // If loading return 
//    
//            // if nextpage
//                // fetch
//    
//        // Fetch 
//            // isLoading = true
//            // Service.fetch(paramaters) 
//    
//                // isLoading = false
//                // If error - send error notification
//    
//                // If response
//                    // Dispatch to background thread (global priority highest)
//                    // Update data in cachedData 
//    
//                    // Dispatch to main thread
//                    // Send data did change notification
//    
//
//    // MARK: - Handle Response
//    
//        // Dispatch async !!
//    
//        // Update data 
//    
//            // If the data is not nil update the data
//    
//                // Update the data in the cache
//    
//    
//}
//
//class TMDbCachedData <Item: NSCoding> {
//    
//    var data = [Item]?
//    
//    // Init met identifier for the file path
//    
//    // Cash delegate 
//        // Cash has delegate
//    
//    
//    
//
//}
//
////class TMDbCacheData<Item: NSCoding> {
////    
////    var data: Item?
////    
////    var lastUpdated: NSDate = NSDate()
////    
////    var refreshTimer: NSTimeInterval = 300
////    
////    var expireInterval: NSTimeInterval?
////    
////    var needsRefresh: Bool {
////        return false
////    }
////    
////    var containsData: Bool {
////        return data != nil
////    }
////    
////    var loading: Bool = false
////    
////    // Loading count
////    
////    // MARK: - Loading
////    
////    func startLoading() {
////        
////    }
////    
////    func stopLoading() {
////        
////        
////    }
////    
////    // MARK: - Update data 
////    
////    func up
////    
////    // MARK - Cache data (Archive)
////    
////    
////    
////    
////    // MARK: - Load Cached data (Unarchive)
////    
////    // MARK: - Reset
////    
////    func reset() {
////        data = nil
////        lastUpdated = nil
////        // Send a change notification
////    }
////    
////}
////
////public class DataManager {
////    
////    let writeQueue = dispatch_queue_create("com.discovermovies.project.write", DISPATCH_QUEUE_SERIAL)
////}
////
////
////
////public li
////
////
////   
////    //
////    //    var filePath : String {
////    //        let manager = NSFileManager.defaultManager()
////    //        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as! NSURL
////    //        return url.URLByAppendingPathComponent("objectsArray").path!
////    //    }
////    //
////    //
////    //}
////    //
////    //// What do we need from this class
////    //
////    //    // It holds a data object that needs to conform to NSCoding so it can be archived
////    //        // It needs to know when it was last updated
////    //        // It should know when it needs to expire
////    //        // It let other classes know if it the data is expired and needs a refresh
////    //        // It should let other classes know when it is loading data
////    //
////    //    // Saving
////    //        // it should know where to save
////    //        // Should happen on a background thread we created
////    //        // Whenever the data is loaded we need to send a notification
////    //
////    //    // Use Every time reloadIfNeeded is called the manager asks this class if the data needs a refresh
////    //        // if refresh
////    //            // DidStartLoading
////    //        // If not refresh
////    //            // Do nothing
////    //
////    //        // If response
////    //            // Manager did stop loading
////    //
////    //        // If cached data is set did change notification
////    //
////    //
////    //public class TMDbDataManager {
////    //    
////    //    private let cache = TMDbMovieListCache
////    //    
////    //    var data: [TMDbMovie]
////    //        return cache.data.items
////    //    }
////    //
////    //
////    //    
////    //    
////    //    
////    //
////    //
////    //
////    //
////    //
////    //
////    //}
////
////
////
////
////
