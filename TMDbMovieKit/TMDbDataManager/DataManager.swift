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
    func dataManager(_ manager: AnyObject, didFailWithError error: APIError)
}

public class DataManager<ModelType: DictionaryRepresentable> {
    
    // MARK: - Properties
    
    public weak var failureDelegate: DataManagerFailureDelegate?
    
    let errorHandler: ErrorHandling
    
    let writesDataToDisk: Bool
    
    let identifier: String
    
    var cachedData: CachedData<ModelType>
    
    var paramaters = [String: AnyObject]()
    
    var isLoading = false
    
    fileprivate let cacheQueue = DispatchQueue(label: "com.discoverMovies.app.cache")
    
    fileprivate let notificationCenter = NotificationCenter.default
    
    // MARK: - Initialize
    
    init(identifier: String, errorHandler: ErrorHandling, writesToDisk: Bool, refreshTimeOut: TimeInterval) {
        self.identifier = identifier
        self.errorHandler = errorHandler
        self.writesDataToDisk = writesToDisk
        self.cachedData = CachedData<ModelType>(refreshTimeOut: refreshTimeOut)
        
        guard writesToDisk else { return }
        self.startLoading()
        self.loadDataFromDisk()
    }
    
    // MARK: - Public API
    
    public func reloadIfNeeded(forceOnline: Bool = false, paramaters params: [String: AnyObject]? = nil) {
        guard cachedData.needsRefresh || forceOnline || params != nil else { return } // On First load send loadingnotification when data is still valid
        if let params = params {
           paramaters = defaultParamaters().merge(params)
        } else {
            paramaters = defaultParamaters()
        }

        loadOnline(paramaters: paramaters)
    }
    
    // MARK: - Paramaters
    
    /**
     Overrride this method to specify a set of default paramaters needed with every request
    */
    
    func defaultParamaters() -> [String: AnyObject] {
        return [:]
    }
    
    // MARK: - Endpoint
    
    /** 
     Override this method to set the endpoint for the GET call
    */
    
    func endpoint() -> String {
        return ""
    }

    // MARK: - Networking
    
    func loadOnline(paramaters params: [String: AnyObject], page: Int = 1) {
        startLoading()
        
        var params = params
        params["page"] = page as AnyObject?
        
        let endpoint = self.endpoint()
        
        Alamofire.request(APIRouter.get(endpoint: endpoint, queryParams: params))
            .validate().responseObject { (response: DataResponse<ModelType>) in
                
                self.stopLoading()
                
                switch response.result {
                case .success(let data):
                    self.handle(data: data)
                    self.cacheData()
                case .failure(let error):
                    let error = self.errorHandler.categorize(error: error)
                    self.failureDelegate?.dataManager(self, didFailWithError: error)
                }
        
        }
        
    }

    
    // MARK: - ResponseHandling

    func handle(data: ModelType) {
        cachedData.add(data)
        postDidLoadNotification()
    }
    
    func cacheData() {
        if self.writesDataToDisk {
            self.writeDataToDisk()
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
    
    public func add(observer: AnyObject, loadingSelector: Selector, didLoadSelector: Selector) {
        add(loadingObserver: observer, selector: loadingSelector)
        add(didLoadObserver: observer, selector: didLoadSelector)
    }
    
    public func add(loadingObserver observer: AnyObject, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: Notification.Name.DataManager.didStartLoading, object: self)
    }
    
    public func add(didLoadObserver observer: AnyObject, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: Notification.Name.DataManager.didLoad, object: self)
    }
    
    public func remove(observer: AnyObject) {
        notificationCenter.removeObserver(observer)
    }
    
    func postLoadingNotification() {
        notificationCenter.post(name: Notification.Name.DataManager.didStartLoading, object: self)
    }
    
    func postDidLoadNotification() {
        notificationCenter.post(name: Notification.Name.DataManager.didLoad, object: self)
    }
    
    // MARK: - Caching
    
    // Caching does not seem to be working after Swift 3 Update
    
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

// MARK: - DataManagerNotification 

extension Notification.Name {
    
    public struct DataManager {
        public static let didLoad = Notification.Name("DataManagerDidLoadNotification")
        public static let didStartLoading = Notification.Name("DataManagerDidStartLoadingNotification")
    }

}
