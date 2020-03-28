//
//  MovieListDataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 05-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import CoreData
import Alamofire

/// `MovieListDataProvider` is a class that fetches a paginated movie list and saves it to the Core Data store.
public class MovieListDataProvider {

    public typealias Completion = (Swift.Result<Void, Error>) -> Void
    
    // MARK: Properties

    /// The cache manager that manages the cache life time of the resource.
    private let cacheManager = CacheManager()

    /// The session manager used for performing network requests.
    private let session: Session

    /// The persistent container that encapsulates the Core Data Stack.
    private let persistentContainer: MovieKitPersistentContainer

    /// Responsible for updating the list managed object with the result of the api call.
    private let listUpdater: ListUpdating
    
    ///
    private let responseQueue = DispatchQueue(label: "")

    /// The type of list that is managed by this data provider.
    private var listType: List.ListType

    /// The API request through with which to retrieve the resource that is managed by this class.
    private var request: ApiRequest

    // MARK: Initialize

    public convenience init(listType: List.ListType) {
        let request = ApiRequest.topList(list: listType.name)
        let session = DiscoverMoviesKit.shared.session
        let listUpdater = ListUpdater(backgroundContext: DiscoverMoviesKit.shared.persistentContainer.backgroundcontext)
        self.init(listType: listType, request: request, persistentContainer: DiscoverMoviesKit.shared.persistentContainer, session: session, listUpdater: listUpdater)
    }

    init(listType: List.ListType, request: ApiRequest, persistentContainer: MovieKitPersistentContainer, session: Session, listUpdater: ListUpdating) {
        self.listType = listType
        self.request = request
        self.persistentContainer = persistentContainer
        self.session = session
        self.listUpdater = listUpdater
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
        // TODO: - We need an object that manages the pages that need to be fetched.
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

    /// Returns an instance of `NSFetchedResultsController` that is configured to listen to changes in the list.
    public func fetchedResultsController() -> NSFetchedResultsController<MovieListData> {
        let fetchRequest = MovieListData.moviesSortedIn(listOf: listType)
        let context = persistentContainer.viewContext
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }

    // MARK: - Networking

    func loadOnline(page: Int64 = 1, completion: Completion? = nil) {
        let params = ["page": page as AnyObject]
        request.add(paramaters: params)
        
        let responseQueue = DispatchQueue.global(qos: .background)
        session.request(request)
            .validate()
            .responseDecodable(of: TMDBResult<TMDBMovie>.self, queue: responseQueue) { [weak self] response in
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
        do {
            try listUpdater.updateList(of: listType, with: data)
            cacheManager.cache(cacheKey: listType.name, lastUpdate: Date())
            completion?(.success(()))
        } catch {
            completion?(.failure(error))
        }
    }
}
