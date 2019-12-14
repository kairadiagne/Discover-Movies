//
//  MovieListDataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 05-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import CoreData
import Alamofire

/// `DataManager` is an abstract class managing data conforming to `Codable` that is persisteted to the user's caches folder.
public class MovieListDataProvider {

    public typealias Completion = (Swift.Result<Void, Error>) -> Void
    
    // MARK: Properties

    /// A `NSFetchedResultsController` used to update the UI about changes in the list.
    public lazy var fetchedResultsController: NSFetchedResultsController<MovieListData> = {
        let fetchRequest = MovieListData.moviesSortedIn(listOf: listType)
        let context = persistentContainer.viewContext
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }()

    /// The persistent container that encapsulates the Core Data Stack.
    private let persistentContainer: MovieKitPersistentContainer

    /// The cache manager that manages the cache life time of the resource.
    private let cacheManager = CacheManager()

    /// The session manager responsible for all network requests.
    private let sessionManager: SessionManager

    /// The API request through with which to retrieve the resource that is managed by this class.
    private var request: ApiRequest

    /// The type of list that is managed by this data provider.
    private var listType: List.ListType

    // MARK: Initialize

    public convenience init(listType: List.ListType, persistentContainer: MovieKitPersistentContainer) {
        let request = ApiRequest.topList(list: listType.name)
        self.init(listType: listType, request: request, persistentContainer: persistentContainer, sessionManager: DiscoverMoviesKit.shared.sessionManager)
    }

    init(listType: List.ListType, request: ApiRequest, persistentContainer: MovieKitPersistentContainer, sessionManager: SessionManager) {
        self.persistentContainer = persistentContainer
        self.sessionManager = sessionManager
        self.request = request
        self.listType = listType
    }

    // MARK: Public API

    public func reloadIfNeeded(forceOnline: Bool = false, completion: Completion? = nil) {
        persistentContainer.backgroundcontext.perform {
            guard forceOnline || self.cacheManager.needsRefresh(cacheKey: self.listType.name, refreshTimeout: 3600) else {
                completion?(.success(()))
                return
            }

            self.loadOnline(completion: completion)
        }
    }

    public func loadMore(completion: Completion? = nil) {
        persistentContainer.backgroundcontext.perform {
            let list = List.list(ofType: self.listType, in: self.persistentContainer.backgroundcontext)

            guard let nextPage = list.nextPage else {
                completion?(.success(()))
                return
            }

            self.loadOnline(page: nextPage, completion: completion)
        }
    }

    // MARK: - Networking

    func loadOnline(page: Int64 = 1, completion: Completion? = nil) {
        let params = ["page": page as AnyObject]
        request.add(paramaters: params)

        let responseQueue = DispatchQueue.global(qos: .background)
        sessionManager.request(request).validate().responseObject(queue: responseQueue) { [weak self] (response: DataResponse<TMDBResult<TMDBMovie>>) in
            guard let self = self else { return }

            switch response.result {
            case .success(let data):
                self.persist(data: data)
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

    func persist(data: TMDBResult<TMDBMovie>, completion: Completion? = nil) {
        persistentContainer.backgroundcontext.performAndWait {
            let list = List.list(ofType: self.listType, in: self.persistentContainer.backgroundcontext)

            if data.page == 1 {
                list.deleteAllMovies()
                list.update(with: data)
            } else if data.page > list.page {
                list.update(with: data)
            }

            cacheManager.cache(cacheKey: listType.name, lastUpdate: Date())

            do {
                try self.persistentContainer.backgroundcontext.save()
                completion?(.success(()))
            } catch {
                completion?(.failure(error))
            }
        }
    }
}
