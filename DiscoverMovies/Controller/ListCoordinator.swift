//
//  ListCoordinator.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import TMDbMovieKit

class ListCoordinator: ItemCoordinator<TMDbMovie> {
    
    private struct Constants {
        static let FavoritesIdentifier = "favorite"
        static let WatchListIdentifier = "watchList"
    }
    
    var identifier = ""
    private let authorizedMovieService: TMDbAuthorizedMovieService!
    
    override init() {
        self.authorizedMovieService = TMDbAuthorizedMovieService()
    }
    
    // MARK: - Service Calls
    
    func fetchList() {
        fetchListWithIdentifier(identifier, page: 1)
    }
    
    override func fetchNextPage() {
        fetchListWithIdentifier(identifier, page: nextPage)
    }
    
    func refresh() {
        clearAllItems()
        fetchListWithIdentifier(identifier, page: 1)
    }
    
    private func fetchListWithIdentifier(identifier: String, page: Int?) {
        authorizedMovieService.fetchMoviesInList(identifier, page: page) { (response) in
            self.handleResponse(response)
        }
    }
    
    // MARK: - Account State
    
    func removeMovie(movie: TMDbMovie, fromList list: String) {
        guard let movieID = movie.movieID else { return }
        guard let index = self.items.indexOf(movie) else { return }
        
        authorizedMovieService.changeAccountStateForMovie(withID: movieID, inList: list, toStatus: false) { (success, error) in
            guard error == nil else {
                self.delegate?.coordinatorDidReceiveError(error!)
                return
            }
            self.removeItemAtIndex(index)
            self.delegate?.coordinatorDidUpdateItems(self.page)
        }
    }
    
}
