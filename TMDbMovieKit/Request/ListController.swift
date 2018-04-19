//
//  MovieListController.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 17-04-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

public protocol ListControllerDelegate: class {
    func listControllerDidStartLoading<T: Object>(_ controller: ListController<T>)
    func listControllerDidFinishInitialLoad<T: Object>(_ controller: ListController<T>)
    func listControllerWillChangeContent<T: Object>(_ controller: ListController<T>)
    func listControlleUpdate<T: Object>(_ controller: ListController<T>, deletions: [Int], insertions: [Int], modifications: [Int])
    func listControllerDidChangeContent<T: Object>(_ controller: ListController<T>)
    func listController<T: Object>(_ controller: ListController<T>, didFailWithError: Error)
}

public class ListController<ModelType: Object> {
    
    // MARK: - Public Properties
    
    public weak var delegate: ListControllerDelegate?
    
    // MARK: - Internal Properties
    
    var result: Results<ModelType>?
    
    // MARK: - Private Properties
    
    private let endpoint: String
    
    private let apiClient: APIClientProtocol

    private let repository: RealmRepositoryType
    
    private let cacheManager: CacheManager
    
    private var notificationToken: NotificationToken?
    
    private var cachedParams = [String: Any]()
    
    // MARK: - Initialize
    
    init(endpoint: String, apiClient: APIClientProtocol = APIClient(), repository: RealmRepositoryType = RealmRepository.shared) {
        self.endpoint = endpoint
        self.apiClient = apiClient
        self.repository = repository
        self.cacheManager = CacheManager()
        subscribeToResult()
    }
    
    deinit {
        unsubscribe()
    }
    
    // MARK: - Loading
    
    public func reloadIfNeeded(forceOnline: Bool = false, paramaters: [String: Any]? = nil) {
        // guard cacheManager.needsUpdate(endpoint, timeout: 0.5) || forceOnline || paramaters != nil else { return }
        cachedParams = paramaters ?? [String: Any]()
        loadOnline(paramaters: cachedParams)
    }
    
    public func loadMore() {
        loadOnline(paramaters: cachedParams, page: 1) // Next page number 
    }
    
    func loadOnline(paramaters params: [String: Any], page: Int = 1) {
        delegate?.listControllerDidStartLoading(self)
        
        var params = params
        params["page"] = page as AnyObject?
        cachedParams = params
        
        apiClient.get(path: endpoint, paramaters: nil, body: nil) { (object: MovieObject) in
            
            self.repository.createOrUpdateObject(object) { error in
                guard let error = error else { return }
                self.delegate?.listController(self, didFailWithError: error)
            }
        }
    }
    
    // MARK: - Subscribe
    
    private func subscribeToResult() {
        notificationToken = result?._observe { [weak self] change in
            guard let strongSelf = self else { return }
            
            switch change {
            case .initial:
                strongSelf.delegate?.listControllerDidFinishInitialLoad(strongSelf)
                
            case .update(_, let deletions, let insertions, let modifications):
                strongSelf.delegate?.listControlleUpdate(strongSelf, deletions: deletions, insertions: insertions, modifications: modifications)
                
            case .error(let error):
                strongSelf.delegate?.listController(strongSelf, didFailWithError: error)
                
            }
        }
    }
    
    private func unsubscribe() {
        notificationToken?.invalidate()
        notificationToken = nil
    }
}


public class MovieObject: Object, Codable {
    @objc dynamic var id = ""
}
