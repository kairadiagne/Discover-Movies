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
    
    let cacheIdentifier: String?
    
    var cachedData: CachedData<ModelType>
    
    let cacheRepository = Repository.cache
    
    var paramaters = [String: AnyObject]()
    
    var isLoading = false
    
    // MARK: - Initialize
    
    init( errorHandler: ErrorHandling, refreshTimeOut: TimeInterval, cacheIdentifier: String? = nil) {
        self.errorHandler = errorHandler
        self.cachedData = CachedData<ModelType>(refreshTimeOut: refreshTimeOut)
        self.cacheIdentifier = cacheIdentifier
    }
    
    // MARK: - Public API
    
    public func reloadIfNeeded(forceOnline: Bool = false, paramaters params: [String: AnyObject]? = nil) { // return bool if loaded or not Zie intergamma 
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
                    self.persistDataIfNeeded()
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
    
    // MARK: - Caching
    
    func persistDataIfNeeded() {
        guard let cacheIdentifier = self.cacheIdentifier else { return }
        guard cachedData.data != nil else { return }
        cacheRepository.persistData(data: cachedData, withIdentifier: cacheIdentifier)
    }
    
    func loadData() {
        guard let cacheIdentifier = cacheIdentifier else { return }
        self.startLoading()
        if let cachedData = cacheRepository.restoreData(forIdentifier: cacheIdentifier) as? CachedData<ModelType> {
            print(cachedData)
            self.postLoadingNotification()
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
        NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name.DataManager.didStartLoading, object: self)
    }
    
    public func add(didLoadObserver observer: AnyObject, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name.DataManager.didLoad, object: self)
    }
    
    public func remove(observer: AnyObject) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func postLoadingNotification() {
        NotificationCenter.default.post(name: Notification.Name.DataManager.didStartLoading, object: self)
    }
    
    func postDidLoadNotification() {
        NotificationCenter.default.post(name: Notification.Name.DataManager.didLoad, object: self)
    }
    
}

// MARK: - DataManagerNotification 

extension Notification.Name {
    
    public struct DataManager {
        public static let didLoad = Notification.Name("DataManagerDidLoadNotification")
        public static let didStartLoading = Notification.Name("DataManagerDidStartLoadingNotification")
    }

}
