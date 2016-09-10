//
//  DataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 05-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public protocol DataManagerFailureDelegate: class {
    func listDataManager(manager: AnyObject, didFailWithError error: APIError)
}

public class DataManager<ModelType: DictionaryRepresentable> {
    
    // MARK: - Properties
    
    public weak var failureDelegate: DataManagerFailureDelegate?
    
    let sessionInfoProvider: SessionInfoContaining
    
    let errorHandler: ErrorHandling
    
    let writesDataToDisk: Bool
    
    let identifier: String
    
    var cachedData: CachedData<ModelType>
    
    var paramaters = [String: AnyObject]()
    
    var isLoading = false
    
    private var firstLoad = true
    
    private let cacheQueue = dispatch_queue_create("com.discoverMovies.app.cache", DISPATCH_QUEUE_SERIAL)
    
    private let notificationCenter = NSNotificationCenter.defaultCenter()
    
    // MARK: - Initialize
    
    init(identifier: String, errorHandler: ErrorHandling = APIErrorHandler(), sessionInfoProvider: SessionInfoContaining, writesToDisk: Bool = true, refreshTimeOut: NSTimeInterval = 3000) {
        self.identifier = identifier
        self.errorHandler = errorHandler
        self.sessionInfoProvider = sessionInfoProvider
        self.writesDataToDisk = writesToDisk
        self.cachedData = CachedData<ModelType>(refreshTimeOut: refreshTimeOut)
        
        if writesDataToDisk {
            self.startLoading()
            self.loadDataFromDisk()
        }
    }
    
    // MARK: - Public API
    
    public func reloadIfNeeded(forceOnline: Bool = false, paramaters params: [String: AnyObject]? = nil) {
        guard cachedData.needsRefresh || forceOnline || params != nil else {
            
            if firstLoad {
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

        loadOnline(paramaters: paramaters)
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
    
    func loadOnline(paramaters params: [String: AnyObject], page: Int = 1) {
        startLoading()
        
        var params = params
        params["page"] = page
        
        let endpoint = self.endpoint()
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: params))
            .validate().responseObject { (response: Response<ModelType, NSError>) in
            
                self.stopLoading()
                
                guard response.result.error == nil else {
                    let error = self.errorHandler.categorize(error: response.result.error!)
                    self.failureDelegate?.listDataManager(self, didFailWithError: error)
                    return
                }
                
                if let data = response.result.value {
                    self.handleData(data)
                    
                    if self.writesDataToDisk {
                        self.writeDataToDisk()
                    }
                }
        }
    }
    
    // MARK: - ResponseHandling

    func handleData(data: ModelType) {
        cachedData.add(data)
        postDidLoadNotification()
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
    
    public func addObserver(observer: AnyObject, loadingSelector: Selector, didLoadSelector: Selector) {
        notificationCenter.addObserver(observer, selector: loadingSelector, name: DataManagerNotification.DidStartLoading, object: self)
        notificationCenter.addObserver(observer, selector: didLoadSelector, name: DataManagerNotification.DidLoad, object: self)
    }
    
    public func addLoadingObserver(observer: AnyObject, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: DataManagerNotification.DidStartLoading, object: self)
    }
    
    public func addDataDidLoadTopObserver(observer: AnyObject, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: DataManagerNotification.DidLoad, object: self)
    }
    
    public func removeObserver(observer: AnyObject) {
        notificationCenter.removeObserver(observer)
    }
    
    func postLoadingNotification() {
        notificationCenter.postNotificationName(DataManagerNotification.DidStartLoading, object: self)
    }
    
    func postDidLoadNotification() {
        notificationCenter.postNotificationName(DataManagerNotification.DidLoad, object: self)
    }
    
    // MARK: - Caching
    
    func writeDataToDisk() {
        // Submit write for asycnhronous execution and return immediately
        dispatch_async(cacheQueue) { [weak self] in
            guard let strongSelf = self else { return }
            let path = strongSelf.getCachesDirectory().stringByAppendingString(strongSelf.identifier)
            NSKeyedArchiver.archiveRootObject(strongSelf.cachedData, toFile: path)
        }
    }
    
    func loadDataFromDisk() {
        self.startLoading()
        
        // Wait until read completes
        dispatch_sync(cacheQueue) { [weak self] in
            guard let strongSelf = self else { return }
            let path = strongSelf.getCachesDirectory().stringByAppendingString(strongSelf.identifier)
            guard let cachedData = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? CachedData<ModelType> else { return }
            strongSelf.cachedData = cachedData
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

public struct DataManagerNotification {
    static let DidStartLoading = "DataManagerDidStartLoadingNotification"
    static let DidLoad = "DataManagerDidLoadNotification"
}






