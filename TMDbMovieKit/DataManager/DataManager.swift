//
//  DataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 05-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public class DataManager<T: Codable> {
    
    // MARK: - Properties

    let apiService = APIService()

    let cacheIdentifier: String?

    let cacheRepository = Repository.cache

    var cachedData: CachedData<T>
    
    var isLoading = false

    // MARK: - Init
    
    init(refreshTimeOut: TimeInterval = 0, cacheIdentifier: String? = nil) {
        self.cachedData = CachedData(refreshTimeOut: refreshTimeOut)
        self.cacheIdentifier = cacheIdentifier
        self.loadData()
    }
    
    // MARK: - Public API
    
    public func reloadIfNeeded(forceOnline: Bool = false) {
        guard cachedData.needsRefresh || forceOnline else { return }
        loadOnline()
    }

    // MARK: - Networking

    func loadOnline() {
        preconditionFailure("This method must be overridden")
    }

    func makeRequest(builder: RequestBuilder) {
        startLoading()

        apiService.executeRequest(builder: builder) { (response: APIResult<T>) in
            self.stopLoading()

            switch response {
            case .failure(let error):
                print(error)
            case .success(let object):
                print(object)
                self.handle(data: object)
                self.persistDataIfNeeded()
            }
        }
    }

    // MARK: - Response

    func handle(data: T) {
        cachedData.data = data
        postUpdateNofitication()
    }
    
    // MARK: - Caching
    
    func persistDataIfNeeded() {
        guard
            let cacheIdentifier = self.cacheIdentifier,
            cachedData.data != nil else {
            return
        }

        cacheRepository.persistData(object: cachedData, cacheKey: cacheIdentifier)
    }
    
    func loadData() {
        guard let cacheIdentifier = cacheIdentifier else {
            return
        }

        startLoading()

        if let cachedData: CachedData<T> = cacheRepository.restoreData(cacheKey: cacheIdentifier) {
            stopLoading()
            self.cachedData = cachedData
            postUpdateNofitication()
        }
    }
    
    public func clear() {
        cachedData.data = nil
        
        if let cacheIdentifier = cacheIdentifier {
            cacheRepository.clearData(cacheKey: cacheIdentifier)
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
