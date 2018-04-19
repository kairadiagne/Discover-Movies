//
//  ObjectController.swift
//  TMDbMovieKit
//
//  Created by Kaira  Diagne on 4/17/18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import RealmSwift

//protocol ObjectControllerDelegate: class {
//    func objectControllerDidUpdate(_ controller: ObjectController)
//    func objectController(_ controller: ObjectController, didFailWithError error: Error)
//    func objectControllerDidStartLoading(_ controller: ObjectController)
//    
//}

class ObjectController<ModelType: Object> {
    
    // MARK: - Public Properties
    
    public internal(set) var object: ModelType?
    
    public let primaryKey: String
    
    // MARK: - Private Properties
    
    private let endpoint: String
    
    private let client: APIClientProtocol
    
    private let repository: RealmRepositoryType
    
    private let cacheManager: CacheManager
    
    private var notificationToken: NotificationToken?
    
    // MARK: - Initialize
    
    init(primaryKey: String, endpoint: String, client: APIClientProtocol = APIClient(), repository: RealmRepository = RealmRepository.shared) {
        self.primaryKey = primaryKey
        self.endpoint = endpoint
        self.client = client
        self.repository = repository
        self.cacheManager = CacheManager()
        self.object = repository.mainRealm.object(ofType: ModelType.self, forPrimaryKey: primaryKey)
    }
    
    deinit {
        unsubscribe()
    }
    
    // MARK: - Load
    
//    func loadDataAndSubscribe(updateBlock: @escaping (ObjectChange) -> Void, completion: (Result) -> Void) {
//        // If cache is still valid 
//        loadOnline()
//    }
    
    func loadOnline() {
        // IN case of movies
        // Dispatch group
        // Load additional info
        // Load Account State
        // Load Reviews
//        client.get(path: endpoint, paramaters: <#T##[String : Any]?#>, body: <#T##[String : Any]?#>, completion: <#T##(Decodable & Encodable) -> ()#>)
//        repository.addOrUpdate(object: <#T##Object#>, refresh: <#T##Bool#>, completion: <#T##RealmRepositoryType.Completion?##RealmRepositoryType.Completion?##(repositoryError?) -> Void#>)
//        notificationToken?.invalidate()
//        notificationToken = object?.observe(updateBlock)
    }
    
    
    func unsubscribe() {
        notificationToken?.invalidate()
        notificationToken = nil
    }
}
