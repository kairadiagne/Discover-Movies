//
//  TMDbListDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 05-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public protocol DataManagerFailureDelegate: class {
    func listDataManager(manager: AnyObject, didFailWithError error: TMDbAPIError)
}

public class TMDbDataManager<ModelType: DictionaryRepresentable>: ErrorHandling {
    
    // MARK: - Properties
    
    public weak var failureDelegate: DataManagerFailureDelegate?
    
    let sessionInfoProvider: SessionInfoContaining
    
    let cacheIdentifier: String
    
    var writesDataToDisk: Bool
    
    var paramaters = [String: AnyObject]()
    
    var cache: TMDbCachedData<ModelType>
    
    private(set) var isLoading = false
    
    private var firstLoad = true
    
    private let cacheQueue = dispatch_queue_create("com.discoverMovies.app.cache", DISPATCH_QUEUE_SERIAL)
    
    private let notificationCenter = NSNotificationCenter.defaultCenter()
    
    // MARK: - Initialize
    
    init(cacheIdentifier: String, sessionInfoProvider: SessionInfoContaining = TMDbSessionInfoStore(), writesDataToDisk: Bool = true, refreshTimeOut: NSTimeInterval = 300) {
        self.cacheIdentifier = cacheIdentifier
        self.sessionInfoProvider = sessionInfoProvider
        self.writesDataToDisk = writesDataToDisk
        self.cache = TMDbCachedData<ModelType>(refreshTimeOut: refreshTimeOut)
        
        if writesDataToDisk {
            self.startLoading()
            self.loadDataFromDisk()
        }
    }
    
    // MARK: - Public API
    
    public func loadTopIfNeeded(forceOnline: Bool, paramaters params: [String: AnyObject]? = nil) {
        guard cache.needsRefresh || forceOnline || params != nil else {
            if firstLoad {
                // If the cache loaded at initialization is still valid post a loading notification 
                firstLoad = false 
                postDidLoadNotification()
            }
            return
        }
    
        if let params = params {
           paramaters = defaultParamaters().merge(params)
        } else {
            paramaters = defaultParamaters()
        }

        loadOnline(paramaters)
    }
    
    // MARK: - Paramaters
    
    /**
     Subclasses should override this method to specify a set of default paramaters needed for every request.
    */
    
    func defaultParamaters() -> [String: AnyObject] {
        return [:]
    }
    
    // MARK: - Endpoint
    
    /** 
     Subclasses need to override this method to set the endpoint for the GET call
    */
    
    func endpoint() -> String {
        return ""
    }

    // MARK: - API Calls
    
    func loadOnline(paramaters: [String: AnyObject], page: Int = 1) {
        startLoading()
        
        var params = paramaters
        params["page"] = page
        
        let endpoint = self.endpoint()
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: params))
            .validate().responseObject { (response: Response<ModelType, NSError>) in
            
                self.stopLoading()
                
                guard response.result.error == nil else {
                    let error = self.categorizeError(response.result.error!)
                    self.failureDelegate?.listDataManager(self, didFailWithError: error)
                    return
                }
                
                if let data = response.result.value {
                    self.handleData(data)
                }
        }
    }
    
    // MARK: - Response
    
    /**
     Is reponsible for handling incoming data.
     - Needs to send DataDidLoadNotification once the data is handled
     - Needs to cache the data once the data is handled
    */

    func handleData(data: ModelType) {
        cache.addData(data)
        self.postDidLoadNotification()
        
        if writesDataToDisk {
            writeDataToDisk()
        }
    }
    
    // MARK: - Loading
    
    func startLoading() {
        isLoading = true
        postLoadingNotification()
    }
    
    func stopLoading() {
        isLoading = false
    }
    
    // MARK: - Notifications
    
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
    
    public func addDataDidUpdateObserver(observer: AnyObject, selector: Selector) { // Finally should be able to be removed
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
    
    // MARK: - Caching
    
    func writeDataToDisk() {
        // Submit write for asycnhronous execution and return immediately
        dispatch_async(cacheQueue) { [weak self] in
            guard let strongSelf = self else { return }
            let path = strongSelf.getCachesDirectory().stringByAppendingString(strongSelf.cacheIdentifier)
            NSKeyedArchiver.archiveRootObject(strongSelf.cache, toFile: path)
        }
    }
    
    func loadDataFromDisk() {
        // Wait until read completes
        dispatch_sync(cacheQueue) { [weak self] in
            guard let strongSelf = self else { return }
            let path = strongSelf.getCachesDirectory().stringByAppendingString(strongSelf.cacheIdentifier)
            guard let cachedData = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? TMDbCachedData<ModelType> else { return }
            strongSelf.cache = cachedData
            self?.stopLoading()
        }
    }
    
    func getCachesDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
        let cachesDirectory = paths[0]
        return cachesDirectory
    }

}

// MARK: - TMDbDataManagerNotification 

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
