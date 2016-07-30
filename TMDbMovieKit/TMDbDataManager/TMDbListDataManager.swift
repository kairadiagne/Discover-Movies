//
//  TMDbListDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 05-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

public protocol DataManagerFailureDelegate: class {
    func listDataManager(manager: AnyObject, didFailWithError error: TMDbAPIError)
}

public class TMDbListDataManager<ModelType: Mappable> {
    
    // MARK: Properties
    
    public weak var failureDelegate: DataManagerFailureDelegate?
    
    public var itemsInList: [ModelType] {
        return cache.data?.items ?? []
    }
    
    public var isLoading = false
    
    private(set) var cache = TMDbCachedData<TMDbList<ModelType>>()
    
    var cacheIdentifier = ""
    
    private let notificationCenter = NSNotificationCenter.defaultCenter()
    
    // MARK: Initializers
    
    init() { }
    
    init(cacheIdentifier: String) {
        self.cacheIdentifier = cacheIdentifier
        // Try to load data from the disk cache and put it into memory cache
    }
    
    // MARK: Public Data Calls
    
    public func reloadTopIfNeeded(forceOnline: Bool) {
        guard cache.needsRefresh || forceOnline else { return }
        loadOnline()
    }
    
    public func loadMore() {
        guard isLoading != true else { return }
        guard let nextPage = cache.data?.nextPage else { return }
        loadOnline(nextPage)
    }
    
    // MARK: API Calls
    
    // Every subclass needs to implement this method.
    // here you make the request to the API.
    
    func loadOnline(page: Int = 1) {
        self.startLoading()
    }

    // MARK: Update List
    
    // We need to do more checks to check if the data is valid or not 
    
    func update(withData data: TMDbList<ModelType>) {
        // If the cache is not empty
        if let list = cache.data {
            list.page = data.page
            list.pageCount = data.pageCount
            list.resultCount = data.resultCount
            
            if data.page == 1 {
               cache.data?.items = data.items
                postDidLoadNotification()
            } else {
                cache.data?.items.appendContentsOf(data.items)
                postDidUpdateNotification()
            }
        } else {
            cache.addData(data)
            postDidLoadNotification()
        }
        // Persist to disk of a backgroundqueue
    }
     
    // MARK: Loading
    
    func startLoading() {
        isLoading = true
        postLoadingNotification()
    }
    
    func stopLoading() {
        isLoading = false
    }
    
    // MARK: Error Handeling
    
    func handleError(error: NSError) {
        var newError: TMDbAPIError
        
        // Determine which kind of error where dealing with
        if error.code == NSURLErrorNotConnectedToInternet {
            newError = .NoInternetConnection
        } else if error.domain == NSURLErrorDomain && error.code == NSURLErrorUserAuthenticationRequired {
            newError = .NotAuthorized
        } else {
            newError = .Generic
        }
        
        failureDelegate?.listDataManager(self, didFailWithError: newError)
    }
    
    // MARK: Notifications
    
    public func addObserver(observer: AnyObject, loadingSelector: Selector, didLoadSelector: Selector, didUpdateSelector: Selector) {
        notificationCenter.addObserver(observer, selector: loadingSelector, name: TMDbListDataManagerNotification.DataDidStartLoading.name, object: self)
        notificationCenter.addObserver(observer, selector: didLoadSelector, name: TMDbListDataManagerNotification.DataDidLoadTop.name, object: self)
        notificationCenter.addObserver(observer, selector: didUpdateSelector, name: TMDbListDataManagerNotification.DataDidUpdate.name, object: self)
    }
    
    public func addLoadingObserver(observer: AnyObject, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: TMDbListDataManagerNotification.DataDidStartLoading.name, object: self)
    }
    
    public func addDataDidLoadTopObserver(observer: AnyObject, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: TMDbListDataManagerNotification.DataDidLoadTop.name, object: self)
    }
    
    public func addDataDidUpdateObserver(observer: AnyObject, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: TMDbListDataManagerNotification.DataDidUpdate.name, object: self)
    }
    
    public func removeObserver(observer: AnyObject) {
        notificationCenter.removeObserver(observer)
    }
    
    func postLoadingNotification() {
        notificationCenter.postNotificationName(TMDbListDataManagerNotification.DataDidStartLoading.name, object: self)
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


// MARK: TMDbDataManagerNotification 

public enum TMDbListDataManagerNotification {
    case DataDidStartLoading
    case DataDidLoadTop
    case DataDidUpdate
    
    public var name: String {
        switch self {
        case DataDidStartLoading:
            return "TMDbListDataManagerDidStartLoading"
        case .DataDidLoadTop:
            return "TMDbListDataManagerDidLoadTop"
        case .DataDidUpdate:
            return "TMDbListDataManagerDidUpdate"
        }
    }
}

