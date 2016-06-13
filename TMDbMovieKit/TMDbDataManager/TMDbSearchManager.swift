//
//  TMDbSearchManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 11-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

enum TMDbSearchType {
    case Discover(year: String, genre: Int, rating: Float)
    case SearchByTitle(title: String)
}

public class TMDbSearchManager: TMDbDataManager {
    
    public var inProgress = false
    
    public var movies: [TMDbMovie] {
        return searchResults.items
    }
    
    private var searchResults = TMDbList<TMDbMovie>()
    
    private var currentSearch: TMDbSearchType?
    
    private let movieClient = TMDbMovieClient()
    
    // MARK: Initializers
    
    public init() { }
    
    // MARK: Fetching
    
    public func discover(year: String, genre: TMDbGenre, rating: Float) {
        currentSearch = .Discover(year: year, genre: genre.rawValue, rating: rating)
    }
    
    public func searchByTitle(query: String) {
        currentSearch = .SearchByTitle(title: query)
    }
    
    public func loadMore() {
        guard let currentSearch = currentSearch else { return }
        guard let nextPage = searchResults.nextPage else { return }
        
        switch currentSearch {
        case .Discover(let year, let genre, let rating):
            discoverMoviesBy(year, genre: genre, rating: rating, page: nextPage)
        case .SearchByTitle(let title):
            fetchMoviesWithTitle(title, page: nextPage)
        }
    }
    
    private func fetchMoviesWithTitle(title: String, page: Int) {
        inProgress = true
        
        movieClient.movieWithTitle(title, page: page) { (response) in
            self.handleResponse(response)
        }
    }
    
    private func discoverMoviesBy(year: String, genre: Int, rating: Float, page: Int) {
        inProgress = true
        
        movieClient.discover(year, genre: genre, vote: rating, page: page) { (response) in
            self.handleResponse(response)
        }
        
    }
    
    // MARK: Response
    
    private func handleResponse(response: Result<TMDbList<TMDbMovie>, NSError>) {
        guard response.error == nil else {
            self.postErrorNotification(response.error!)
            return
        }
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            if let results = response.value {
               self.searchResults.update(results)
                
            
                dispatch_async(dispatch_get_main_queue(), { 
                    if results.page == 1 {
                        self.postUpdateNotification()
                    } else if results.page < 1 {
                        self.postChangeNotification()
                    }
                })
            }
        }
        
    }
     
}


