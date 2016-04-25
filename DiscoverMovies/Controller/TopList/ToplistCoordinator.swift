//
//  ToplistCoordinator.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import TMDbMovieKit

class ToplistCoordinator: ItemCoordinator<TMDbMovie> {
    
    private let movieService: TMDbMovieService
    private var currentList: TMDbToplist = .Popular
    
    override init() {
        self.movieService = TMDbMovieService(APIKey: Global.APIKey)
    }
    
    // MARK: - Service Calls
    
    func fetchMoviesInTopList(list: TMDbToplist) {
        currentList = list
        fetchTopList(list, page: 1)
    }
    
    override func fetchNextPage() {
        fetchTopList(currentList, page: nextPage)
    }
    
    private func fetchTopList(list: TMDbToplist, page: Int?) {
        inProgress = true
        movieService.fetchTopList(list.rawValue, page: page, completionHandler: { [weak self] (response) in
            self?.handleResponse(response)
        })
    }
    
}

