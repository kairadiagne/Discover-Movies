//
//  DetailCoordinator.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import TMDbMovieKit

class DetailCoordinator: ItemCoordinator<TMDbMovie> {
    
    private struct Constants {
        static let FavoritesIdentifier = "favorite"
        static let WatchListIdentifier = "watchList"
    }
    
    var inFavorites: Bool?
    var inWatchList: Bool?
    var trailer: TMDbVideo?
    var userStatus: TMDBSiginStatus
    
    private let movieService: TMDbMovieService
    
    override init() {
        self.movieService = TMDbMovieService(APIKey: Global.APIKey)
        self.userStatus = TMDbUserInfoStore().userStatus
    }
    
    // MARK: - Similar Movies
    
    func fetchSimilarMovies(movieID: Int) {
        fetchSimilarMoviesToMovie(with: movieID, page: 1)
    }
    
    func fetchNextPage(movieID: Int) {
        fetchSimilarMoviesToMovie(with: movieID, page: page)
    }
    
    private func fetchSimilarMoviesToMovie(with movieID: Int, page: Int) {
        movieService.fetchMoviesSimilarToMovie(withID: movieID, page: page) { (response) in
            self.handleResponse(response)
        }
    }
    
    // MARK: - Account states
    
    func getAccountStates(movieID: Int) {
        guard userStatus == .Signedin else { return } // If the user is not signed there is no need to check the account state
        movieService.accountStateForMovie(movieID) { [weak self] (response) in
            guard let inFavorites = response.inFavorites, inWatchList = response.inWatchList else { return }
            self?.inFavorites = inFavorites
            self?.inWatchList = inWatchList
            self?.delegate?.coordinatorDidUpdateItems(self?.page)
        }
    }
    
    func addToList(movieID: Int, list: String) {
        movieService.changeAccountStateForMovie(withID: movieID, inList: list, toStatus: true) { [weak self] (success, error) in
            guard error == nil else {
                self?.delegate?.coordinatorDidReceiveError(error!)
                return
            }
            if list == Constants.FavoritesIdentifier && success {
                self?.inFavorites = true
            } else if list == Constants.WatchListIdentifier && success {
                self?.inWatchList = true
            }
        }
    }
    
    func removeFromList(movieID: Int, list: String) {
        movieService.changeAccountStateForMovie(withID: movieID, inList: list, toStatus: false) { [weak self] (success, error) in
            guard error == nil else {
                self?.delegate?.coordinatorDidReceiveError(error!)
                return
            }
            if list == Constants.FavoritesIdentifier && success {
                self?.inFavorites = false
            } else if list == Constants.WatchListIdentifier {
                self?.inWatchList = false
            }
        }
    }
    
    // MARK: - Trailer
    
    func fetchTrailer(movieID: Int) {
        movieService.fetchVideosForMovie(movieID) { [weak self] (response) in
            guard let videos = response.result else { return }
            let trailers = videos.filter { $0.type == "Trailer" }
            self?.trailer = trailers.first
        }
    }
    
}

 