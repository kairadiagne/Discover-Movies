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
    func listDataManager(_ manager: AnyObject, didFailWithError error: APIError)
}

open class DataManager<ModelType: DictionaryRepresentable> {
    
    // MARK: - Properties
    
    open weak var failureDelegate: DataManagerFailureDelegate?
    
    let sessionInfoProvider: SessionInfoContaining
    
    let errorHandler: ErrorHandling
    
    let writesDataToDisk: Bool
    
    let identifier: String
    
    var cachedData: CachedData<ModelType>
    
    var paramaters = [String: AnyObject]()
    
    var isLoading = false
    
    fileprivate var firstLoad = true
    
    fileprivate let cacheQueue = DispatchQueue(label: "com.discoverMovies.app.cache", attributes: [])
    
    fileprivate let notificationCenter = NotificationCenter.default
    
    // MARK: - Initialize
    
    init(identifier: String, errorHandler: ErrorHandling = APIErrorHandler(), sessionInfoProvider: SessionInfoContaining, writesToDisk: Bool = true, refreshTimeOut: TimeInterval = 3000) {
        self.identifier = identifier
        self.errorHandler = errorHandler
        self.sessionInfoProvider = sessionInfoProvider
        self.writesDataToDisk = writesToDisk
        self.cachedData = CachedData<ModelType>(coder: refreshTimeOut)
        
        if writesDataToDisk {
            self.startLoading()
            self.loadDataFromDisk()
        }
    }
    
    // MARK: - Public API
    
    open func reloadIfNeeded(_ forceOnline: Bool = false, paramaters params: [String: AnyObject]? = nil) {
        guard cachedData.needsRefresh || forceOnline || params != nil else {
            
            if firstLoad { /// Bug on first load it should always post this notification
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
        params["page"] = page as AnyObject?
        
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

    func handleData(_ data: ModelType) {
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
    
    open func addObserver(_ observer: AnyObject, loadingSelector: Selector, didLoadSelector: Selector) {
        notificationCenter.addObserver(observer, selector: loadingSelector, name: NSNotification.Name(rawValue: DataManagerNotification.DidStartLoading), object: self)
        notificationCenter.addObserver(observer, selector: didLoadSelector, name: NSNotification.Name(rawValue: DataManagerNotification.DidLoad), object: self)
    }
    
    open func addLoadingObserver(_ observer: AnyObject, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: DataManagerNotification.DidStartLoading), object: self)
    }
    
    open func addDataDidLoadTopObserver(_ observer: AnyObject, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: DataManagerNotification.DidLoad), object: self)
    }
    
    open func removeObserver(_ observer: AnyObject) {
        notificationCenter.removeObserver(observer)
    }
    
    func postLoadingNotification() {
        notificationCenter.post(name: Notification.Name(rawValue: DataManagerNotification.DidStartLoading), object: self)
    }
    
    func postDidLoadNotification() {
        notificationCenter.post(name: Notification.Name(rawValue: DataManagerNotification.DidLoad), object: self)
    }
    
    // MARK: - Caching
    
    func writeDataToDisk() {
        // Submit write for asycnhronous execution and return immediately
        cacheQueue.async { [weak self] in
            guard let strongSelf = self else { return }
            let path = strongSelf.getCachesDirectory() + strongSelf.identifier
            NSKeyedArchiver.archiveRootObject(strongSelf.cachedData, toFile: path)
        }
    }
    
    func loadDataFromDisk() {
        self.startLoading()
        
        // Wait until read completes
        cacheQueue.sync { [weak self] in
            guard let strongSelf = self else { return }
            let path = strongSelf.getCachesDirectory() + strongSelf.identifier
            guard let cachedData = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? CachedData<ModelType> else { return }
            strongSelf.cachedData = cachedData
            self?.stopLoading()
        }
    }
    
    func getCachesDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        let cachesDirectory = paths[0]
        return cachesDirectory
    }

}

// MARK: - TMDbDataManagerNotification 

public struct DataManagerNotification {
    static let DidStartLoading = "DataManagerDidStartLoadingNotification"
    static let DidLoad = "DataManagerDidLoadNotification"
}






