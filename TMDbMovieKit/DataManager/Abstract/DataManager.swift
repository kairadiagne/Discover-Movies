//
//  DataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 05-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

/// `DataManager` is an abstract class managing data conforming to `Codable` that is persisteted to the user's caches folder.
public class DataManager<ModelType: Codable> {
    
    // MARK: - Properties

    let sessionManager: SessionManager
    
    let cacheRepository = Repository.cache
    
    var cachedData: CachedData<ModelType>

    private var request: ApiRequest
    
    let cacheIdentifier: String?
    
    var cachedParams = [String: AnyObject]()
    
    var isLoading = false

    // MARK: - Initialize
    
    init(request: ApiRequest, refreshTimeOut: TimeInterval, cacheIdentifier: String? = nil, sessionManager: SessionManager = DiscoverMoviesKit.shared.sessionManager) {
        self.request = request
        self.cachedData = CachedData(refreshTimeOut: refreshTimeOut)
        self.cacheIdentifier = cacheIdentifier
        self.sessionManager = sessionManager
        self.loadData()
    }
    
    // MARK: - Public API
    
    public func reloadIfNeeded(forceOnline: Bool = false, paramaters params: [String: AnyObject]? = nil) {
        guard cachedData.needsRefresh() || forceOnline || params != nil else { return }
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

        sessionManager.request(request).validate().responseObject { [weak self] (response: DataResponse<ModelType>) in
            guard let self = self else { return }

            self.stopLoading()

            switch response.result {
            case .success(let data):
                self.handle(data: data)
                self.persistDataIfNeeded()
            case .failure(let error):
                self.post(event: .didFailWithError(error))
            }
        }
    }

    // MARK: - Response

    func handle(data: ModelType) {
        cachedData.data = data
        post(event: .didUpdate)
    }
    
    // MARK: - Caching
    
    func persistDataIfNeeded() {
        guard let cacheIdentifier = self.cacheIdentifier else { return }
        guard cachedData.data != nil else { return }
        cacheRepository.persistData(data: cachedData, withIdentifier: cacheIdentifier, completion: nil)
    }
    
    func loadData() {
        guard let cacheIdentifier = cacheIdentifier else { return }
        self.startLoading()
        if let cachedData: CachedData<ModelType> = cacheRepository.restoreData(forIdentifier: cacheIdentifier) {
            self.stopLoading()
            self.cachedData = cachedData
            self.post(event: .didUpdate)
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
        post(event: .didStartLoading)
    }
    
    func stopLoading() {
        isLoading = false
    }
    
    // MARK: - Notifications

    func post(event: DataManagerUpdateEvent) {
        NotificationCenter.default.post(name: DataManagerUpdateEvent.dataManagerUpdateNotificationName, object: self, userInfo: event.userInfo)
    }
    
    public func add(observer: AnyObject, updateSelector: Selector, queue: DispatchQueue) {
        NotificationCenter.default.addObserver(observer, selector: updateSelector, name: DataManagerUpdateEvent.dataManagerUpdateNotificationName, object: self)
    }
    
    public func remove(observer: AnyObject) {
        NotificationCenter.default.removeObserver(observer)
    }
}
