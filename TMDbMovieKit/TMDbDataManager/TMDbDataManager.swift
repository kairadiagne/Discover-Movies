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

public class TMDbDataManager<ModelType: DictionaryRepresentable> {
    
    // MARK: - Properties
    
    public weak var failureDelegate: DataManagerFailureDelegate?
    
    let sessionInfoProvider: SessionInfoContaining
    
    var paramaters = [String: AnyObject]()
    
    let cacheIdentifier: String 
    
    private(set) var cache = TMDbCachedData<ModelType>()
    
    private let cacheQueue = dispatch_queue_create("com.discoverMovies.app.cache", DISPATCH_QUEUE_SERIAL)
    
    private(set) var isLoading = false
    
    private let notificationCenter = NSNotificationCenter.defaultCenter()
    
    // MARK: - Initialize
    
    init(cacheIdentifier: String = "", sessionInfoProvider: SessionInfoContaining = TMDbSessionInfoStore()) {
        self.cacheIdentifier = cacheIdentifier
        self.sessionInfoProvider = sessionInfoProvider
        self.loadFromDisk()
    }
    
    deinit {
        saveToDisk()
    }
    
    // MARK: - Public API
    
    public func loadTopIfNeeded(forceOnline: Bool, paramaters params: [String: AnyObject]? = nil) {
        guard cache.needsRefresh || forceOnline || params != nil else { return }
        
        // Merge params into defaultParamaters
        if let params = params {
           paramaters = defaultParamaters().merge(params)
        }

        loadOnline(paramaters)
    }
    
    public func loadMore() {
        guard isLoading == false else { return }
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
        
        // Add page key to paramaters
        var params = paramaters
        params["page"] = page
        
        let endpoint = self.endpoint()
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: params))
            .validate().responseObject { (response: Response<ModelType, NSError>) in
            
                self.stopLoading()
                
                guard response.result.error == nil else {
                    self.handle(error: response.result.error!)
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
        self.saveToDisk()
    }
    
    // MARK: - Loading
    
    func startLoading() {
        isLoading = true
        postLoadingNotification()
    }
    
    func stopLoading() {
        isLoading = false
    }
    
    // MARK: - Error Handeling

    func handle(error error: NSError) {
        var newError: TMDbAPIError
        
        if error.code == NSURLErrorNotConnectedToInternet {
            newError = .NoInternetConnection
        } else if error.code == NSURLErrorUserAuthenticationRequired {
            newError = .NotAuthorized
        } else {
            newError = .Generic
        }
        
        failureDelegate?.listDataManager(self, didFailWithError: newError)
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
    
    // MARK: - Disk Cache
    
    func saveToDisk() {
        dispatch_async(cacheQueue) { // Retain Cycle??
            guard let data = self.cache.data else { return }
            let fileName = self.getCachesDirectory().stringByAppendingString(self.cacheIdentifier)
            NSKeyedArchiver.archiveRootObject(data.dictionaryRepresentation(), toFile: fileName)
        }
        
    }
    
    func loadFromDisk() {
        dispatch_async(cacheQueue) {
            let fileName = self.getCachesDirectory().stringByAppendingString(self.cacheIdentifier)
            
            guard let dict = NSKeyedUnarchiver.unarchiveObjectWithFile(fileName) as? [String: AnyObject],
                object = ModelType(dictionary: dict) else {
                    print("Reading data from disk failed")
                    return
            }
            
            self.cache.addData(object)
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
