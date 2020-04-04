//
//  MovieDetailManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Alamofire
import CoreData

public final class MovieDetailDataProvider {
    
    // MARK: - Properties
    
    /// The movie for which this provider manages the details.
    public var movie: Movie?

    /// The persistent container that encapsulates the Core Data Stack.
    private let persistentContainer: MovieKitPersistentContainer

    /// The session used to make requests to the movie database API.
    private let session: Session

    // MARK: Initialize
    
    public convenience init(managedObjectID: NSManagedObjectID) {
        self.init(managedObjectID: managedObjectID, persistentContainer: DiscoverMoviesKit.shared.persistentContainer, session: DiscoverMoviesKit.shared.session)
    }
    
    init(managedObjectID: NSManagedObjectID, persistentContainer: MovieKitPersistentContainer, session: Session) {
        self.persistentContainer = persistentContainer
        self.session = session
        self.movie = try? persistentContainer.viewContext.existingObject(with: managedObjectID) as? Movie
    }

    // MARK: Public API
    
    public func fetchAdditionalDetails(completion: @escaping () -> Void) {
        guard let movie = movie else {
            completion()
            return
        }
        
        let objectID = movie.objectID
        
        let context = persistentContainer.backgroundcontext
        
        let endpoint = ApiRequest.movieDetail(movieID: Int(movie.identifier))
        session.request(endpoint).validate().responseDecodable(of: TMDBMovieInfo.self) { response in
            switch response.result {
            case .success(let movieInfo):
                self.persistentContainer.backgroundcontext.perform {
                    guard let movie = try? self.persistentContainer.backgroundcontext.existingObject(with: objectID) as? Movie else {
                        DispatchQueue.main.async {
                            completion()
                        }
                        return
                    }
                    // In case of moview credit support we also have to save the movie.
                    _ = movieInfo.trailers.compactMap { Video.insert(into: context, video: $0, movie: movie) }
                    _ = movieInfo.cast.compactMap { CastMember.insert(into: context, castMember: $0, movie: movie) }
                    _ = movieInfo.crew.compactMap { CrewMember.insert(into: context, crewMember: $0, movie: movie) }
                    
                    try! self.persistentContainer.backgroundcontext.save()
                }
                
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    completion()
                }
            }
        }
    }

    /// Changes the status of the movie in the specified list.
    /// - Parameter list: The list to add or remove the movie to.
    /// - Parameter status: True will add the movie to the list, false will remove the movie from the list.
    public func toggleStatusOfMovieInList(_ list: String, status: Bool) {
    }

    /// Loads the status fo the movie in the watchlist and favoriteslist.
    public func loadAccountState() {
    }
    
    //  super.init(request: ApiRequest.movieDetail(movieID: movieID), refreshTimeOut: 0, cacheIdentifier: "\(movieID)")
}
