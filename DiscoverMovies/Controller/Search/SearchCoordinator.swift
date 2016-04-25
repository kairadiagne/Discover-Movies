//
//  SearchCoordinator.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import TMDbMovieKit

enum Search {
    case Discover(year: String?, genre: Int?, averageVote: Float?)
    case SearchByTitle(title: String)
}

class SearchCoordinator: ItemCoordinator<TMDbMovie> {
    
    private let movieService: TMDbMovieService
    private var currentSearch: Search?
    
    override init() {
        self.movieService = TMDbMovieService(APIKey: Global.APIKey)
    }
    
    // MARK: - Service Calls
    
    func discoverMoviesBy(year: String?, genre: Int?, averageVote: Float?) {
        discover(year, genre: genre, averageVote: averageVote, page: 1)
    }
    
    func searchMoviesBy(title: String) {
        searchByTitle(title, page: 1)
    }
    
    override func fetchNextPage() {
        guard let currentSearch = currentSearch else { return }
        switch currentSearch {
        case .Discover(let year, let genre, let averageVote):
            discover(year, genre: genre, averageVote: averageVote, page: nextPage)
        case .SearchByTitle(let title):
            searchByTitle(title, page: nextPage)
        }
    }
    
    private func discover(year: String?, genre: Int?, averageVote: Float?, page: Int?) {
        inProgress = true
        currentSearch = .Discover(year: year, genre: genre, averageVote: averageVote)
        movieService.discoverMovies(year, genre: genre, vote: averageVote, page: page ) { [weak self] (response) in
            self?.handleResponse(response)
        }
    }
    
    private func searchByTitle(title: String, page: Int?) {
        inProgress = true
        currentSearch = .SearchByTitle(title: title)
        movieService.searchForMovieWith(title, page: page) { [weak self] (response) in
            self?.handleResponse(response)
        }
    }
    
}


