//
//  TMDbDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 05-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

protocol ListDataManagerFailureDelegate: class {
    func listDataManager(manager: DataManager, didFailWithError: TMDbAPIError)
}

public class TMDbListDataManager<ModelType: Mappable> {
    
    // MARK: Properties 
    
    public weak var failureDelegate: ListDataManagerFailureDelegate?
    
    public var itemsInList: [ModelType] {
        return cachedData?.data?.items ?? []
    }
    private(set) var isLoading = false
    
    private(set) var cachedData =  TMDbCachedData<TMDbList<ModelType>> {
        didSet {
            // Write to cache
        }
    }
    
    private var cacheIdentifier = ""
    
    private let notificationCenter = NSNotificationCenter.defaultCenter()
    
    // MARK: Initializers
    
    public init(cacheIdentifier: String) {
        self.cacheIdentifier = cacheIdentifier
        // Try to load data from the disk cache and put it into memory cache
    }
    
    // MARK: Public Data Calls
    
    public func reloadTopIfNeeded(forceOnline: Bool) {
        guard cachedData?.needsUpdate || forceOnline else { return }
        loadOnline()
    }
    
    public func loadMore(page: Int? = nil) {
        guard let nextPage = cachedData.data?.items else { return }
        guard let isLoading != true else { return }
        
        loadOnline(page: nextPage)
    }
    
    // MARK: API Calls
    
    /**
        Every subclass needs to implement this method.
        This is where the actual request to the WEBAPI is being made.
     */
    func loadOnline(page: Int = 1) { }
    
    // MARK: Update List
    
    func update(list: TMDbList<ModelType>, withData data: TMDbList<ModelType>) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { 
            list.update(data)
            // Save to disk 
            
            dispatch_async(dispatch_get_main_queue(), {
                self.cachedData.data = list
                
                // Post Notifications
                let page = cachedData.data.page
                
                if page == 1 {
                
                } else if page > 1 {
                    
                }
            }
        }
    }
    
    // MARK: Error Handeling
    
    func handleError(error: NSError) {
        var error: TMDbAPIError
        
        // Determine which kind of error where dealing with
        if error.code == NSURLErrorNotConnectedToInternet {
            error = .NoInternetConnection
        } else if error.domain == NSURLErrorDomain && error.code == NSURLErrorUserAuthenticationRequired {
            error = .NotAuthorized
        } else {
            error = .Generic
        }
        
        // Call delegate method to communicate the error to UI Level
        failureDelegate?.dataManager(manager: self, didFailWithError: error)
    }
    
    // MARK: Notifications
    
    public func addLoadingObserver(observer: AnyObject, selector: Selector) {
        notificationCenter.addObserver(observer, selector: Selector, name: TMDbListDataManagerNotification.DataDidUpdate.name, object: self)
    }
    
    public func addDataDidLoadTopObserver(observer: AnyObject, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: TMDbListDataManagerNotification.DataDidLoadTop.name, object: self)
    }
    
    public func addDataDidUpdateObserver(observer: AnyObject, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: TMDbListDataManagerNotification.DataDidUpdate.name, object: self)
    }
    
    func postLoadingNotification() {
        notificationCenter.postNotificationName(TMDbListDataManagerNotification.DataDidLoadTop.name, object: self)
    }
    
    func postDidLoadNotification() {
        notificationCenter.postNotificationName(TMDbListDataManagerNotification.DataDidLoadTop.name, object: self)
    }
    
    func postDidUpdateNotification() {
        notificationCenter.postNotificationName(TMDbListDataManagerNotification.DataDidUpdate.name, object: self)
    }
    
    // MARK: Disk Cache 
    
    func saveToDisk() {
        
    }
    
    func loadFromDisk() {
        
    }

}

enum TMDbAPIError: ErrorType {
    case Generic
    case NoInternetConnection
    case NotAuthorized
}


// MARK: - List 

public enum TMDbAccountList: String {
    case Favorites = "favorite"
    case Watchlist = "watchlist"
}

public enum TMDbToplist: String {
    case Popular = "popular"
    case TopRated = "top_rated"
    case Upcoming = "upcoming"
    case NowPlaying = "now_playing"
}



// MARK: TMDbDataManagerNotification 

public enum TMDbListDataManagerNotification {
    case DataDidStartLoading
    case DataDidLoadTop
    case DataDidUpdate
    
    public var name: String {
        switch self {
        case DataIsLoading:
            return "TMDbListDataManagerDidStartLoading"
        case .DataDidLoadTop:
            return "TMDbListDataManagerDidLoadTop"
        case .DataDidUpdate:
            return "TMDbListDataManagerDidUpdate"
        }
    }
}

