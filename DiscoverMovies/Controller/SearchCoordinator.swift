//
//  SearchCoordinator.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import TMDbMovieKit

enum SearchType {
    case Discover(year: String?, genre: Int?, averageVote: Float?)
    case SearchByTitle(title: String)
}

class SearchCoordinator: ItemCoordinator<TMDbMovie> {
    
    private var movieService: TMDbMovieService!
    private var currentSearch: SearchType?
    
    override init() {
        self.movieService = TMDbMovieService()
    }
    
    // MARK: - Service Calls
    
    func discoverMoviesBy(year: String?, genre: Int?, averageVote: Float?) {
        discover(year, genre: genre, averageVote: averageVote, page: 1)
    }
    
    func searchMoviesBy(title: String) {
        searchByTitle(title, page: 1)
    }
    
    override func fetchNextPage() {
        guard let currentSearch = currentSearch else { return } // TODO: Handle this error
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
        movieService.discoverMovies(year, genre: genre, voteAverage: averageVote, page: page ) { (response) in
            self.handleResponse(response)
        }
    }
    
    private func searchByTitle(title: String, page: Int?) {
        inProgress = true
        currentSearch = .SearchByTitle(title: title)
        movieService.searchForMovieWith(title, page: page) { (response) in
            self.handleResponse(response)
        }
    }
    
}


