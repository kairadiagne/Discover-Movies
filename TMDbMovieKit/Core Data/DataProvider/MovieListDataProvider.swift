//
//  MovieListDataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 05-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import CoreData
import Alamofire

/// `MovieListDataProvider` is a class that fetches a paginated movie list andsaves it to the Core Data store.
public class MovieListDataProvider {

    public typealias Completion = (Swift.Result<Void, Error>) -> Void
    
    // MARK: Properties

    /// The cache manager that manages the cache life time of the resource.
    private let cacheManager = CacheManager()

    /// The session manager used for performing network requests.
    private let sessionManager: SessionManager

    /// The persistent container that encapsulates the Core Data Stack.
    private let persistentContainer: MovieKitPersistentContainer

    /// Responsible for updating the list managed object with the result of the api call.
    private let listController: ListController

    /// The type of list that is managed by this data provider.
    private var listType: List.ListType

    /// The API request through with which to retrieve the resource that is managed by this class.
    private var request: ApiRequest

    // MARK: Initialize

    public convenience init(listType: List.ListType) {
        let request = ApiRequest.topList(list: listType.name)
        let listController = ListController(backgroundContext: DiscoverMoviesKit.shared.persistentContainer.backgroundcontext)
        self.init(listType: listType, request: request, persistentContainer: DiscoverMoviesKit.shared.persistentContainer, sessionManager: DiscoverMoviesKit.shared.sessionManager, listController: listController)
    }

    init(listType: List.ListType, request: ApiRequest, persistentContainer: MovieKitPersistentContainer, sessionManager: SessionManager, listController: ListController) {
        self.listType = listType
        self.request = request
        self.persistentContainer = persistentContainer
        self.sessionManager = sessionManager
        self.listController = listController
    }

    // MARK: Public API

    public func reloadIfNeeded(forceOnline: Bool = false, completion: Completion? = nil) {
        guard forceOnline || cacheManager.needsRefresh(cacheKey: listType.name, refreshTimeout: 86400) else {
            completion?(.success(()))
            return
        }

        loadOnline(completion: completion)
    }

    public func loadMore(completion: Completion? = nil) {
        var nextPage: Int64?
        persistentContainer.backgroundcontext.performAndWait {
            let list = List.list(ofType: self.listType, in: self.persistentContainer.backgroundcontext)
            nextPage = list.nextPage
        }

        guard let page = nextPage else {
            completion?(.success(()))
            return
        }

        loadOnline(page: page, completion: completion)
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
        listController.updateList(of: listType, with: data) { result in
            switch result {
            case .success:
                self.cacheManager.cache(cacheKey: self.listType.name, lastUpdate: Date())
                completion?(.success(()))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

    /// A `NSFetchedResultsController` used to update the UI about changes in the list.
     public lazy var fetchedResultsController: NSFetchedResultsController<MovieListData> = {
         let fetchRequest = MovieListData.moviesSortedIn(listOf: listType)
         let context = persistentContainer.viewContext
         return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
     }()
}
