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
    
    let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        return SessionManager(configuration: configuration)
    }()
    
    // MARK: - Initialize
    
    init(errorHandler: ErrorHandling, refreshTimeOut: TimeInterval, cacheIdentifier: String? = nil) {
        self.errorHandler = errorHandler
        self.cacheIdentifier = cacheIdentifier
        self.cachedData = CachedData(refreshTimeOut: refreshTimeOut)
        self.loadData()
    }
    
    // MARK: - Public API
    
    public func reloadIfNeeded(forceOnline: Bool = false, paramaters params: [String: AnyObject]? = nil) {
        guard cachedData.needsRefresh || forceOnline || params != nil else { return }
        
        if let params = params {
           paramaters = defaultParamaters().merge(params)
        } else {
            paramaters = defaultParamaters()
        }

        loadOnline(paramaters: paramaters)
    }
    
    // MARK: - Paramaters
    
    /**
     Designated for subclass: Specifies a set of default paramaters that are required for every request
    */
    
    func defaultParamaters() -> [String: AnyObject] {
        return [:]
    }
    
    // MARK: - Endpoint
    
    /** 
     Designated for subclass: Specfies the endpoint for the GET call
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
        
        sessionManager.request(APIRouter.get(endpoint: endpoint, queryParams: params))
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
        postUpdateNofitication()
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
            self.stopLoading()
            self.cachedData = cachedData
            self.postUpdateNofitication()
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
    
    public func add(observer: AnyObject, loadingSelector: Selector, updateSelector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: loadingSelector, name: Notification.Name.DataManager.didStartLoading, object: self)
        NotificationCenter.default.addObserver(observer, selector: updateSelector, name: Notification.Name.DataManager.update, object: self)
    }
    
    public func remove(observer: AnyObject) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func postUpdateNofitication() {
        NotificationCenter.default.post(name: Notification.Name.DataManager.update, object: self)
    }
    
    func postLoadingNotification() {
        NotificationCenter.default.post(name: Notification.Name.DataManager.didStartLoading, object: self)
    }
    
}

// MARK: - DataManagerNotification 

extension Notification.Name {
    
    public struct DataManager {
        public static let update = Notification.Name("DataManagerDidUpdateNotification")
        public static let didStartLoading = Notification.Name("DataManagerDidStartLoading")
    }

}
