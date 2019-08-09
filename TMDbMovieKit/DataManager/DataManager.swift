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

public class DataManager<ModelType: DictionarySerializable> {
    
    // MARK: - Properties
    
    public weak var failureDelegate: DataManagerFailureDelegate?
    
    private var request: ApiRequest
    
    let cacheRepository = Repository.cache
    
    var cachedData: CachedData<ModelType>
    
    let cacheIdentifier: String?
    
    var cachedParams = [String: AnyObject]()
    
    var isLoading = false
    
    // MARK: - Initialize
    
    init(request: ApiRequest, refreshTimeOut: TimeInterval, cacheIdentifier: String? = nil) {
        self.request = request
        self.cachedData = CachedData(refreshTimeOut: refreshTimeOut)
        self.cacheIdentifier = cacheIdentifier
        self.loadData()
    }
    
    // MARK: - Public API
    
    public func reloadIfNeeded(forceOnline: Bool = false, paramaters params: [String: AnyObject]? = nil) {
        guard cachedData.needsRefresh || forceOnline || params != nil else { return }
        cachedParams = params ?? [:]
        loadOnline(paramaters: cachedParams)
    }

    // MARK: - Networking
    
    func loadOnline(paramaters params: [String: AnyObject], page: Int = 1) {
        startLoading()
        
        var params = params
        params["page"] = page as AnyObject?
        cachedParams = params
        request.add(paramaters: params)

        NetworkManager.shared.sessionManager.request(request)
            .validate().responseObject { (response: DataResponse<ModelType>) in
        
                self.stopLoading()
                
                switch response.result {
                case .success(let data):
                    self.handle(data: data)
                    self.persistDataIfNeeded()
                case .failure(let error):
                    if let error = error as? APIError {
                       self.failureDelegate?.dataManager(self, didFailWithError: error)
                    } else {
                        self.failureDelegate?.dataManager(self, didFailWithError: .generic)
                    }
                }
        }
    }

    // MARK: - Response

    func handle(data: ModelType) {
        cachedData.data = data
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
    
    public func clear() {
        cachedData.data = nil
        
        if let cacheIdentifier = cacheIdentifier {
            cacheRepository.clearData(withIdentifier: cacheIdentifier)
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
