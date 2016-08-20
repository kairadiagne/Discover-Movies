////
////  TMDbSearchManager.swift
////  DiscoverMovies
////
////  Created by Kaira Diagne on 11-06-16.
////  Copyright © 2016 Kaira Diagne. All rights reserved.
////
//
//import Foundation
//import Alamofire
//
//public enum TMDbSearchType {
//    case Discover(year: String, genre: Int, rating: Float)
//    case SearchByTitle(title: String)
//}
//
//public class TMDbSearchManager: TMDbBaseDataManager {
//    
//    public var movies: [TMDbMovie] {
//        return searchResults.items
//    }
//    
//    private var searchResults = TMDbList<TMDbMovie>()
//    
//    private var currentSearch: TMDbSearchType?
//    
//    private let movieClient = TMDbMovieClient()
//    
//    // MARK: API Calls 
//    
//    public func discover(year: String, genre: TMDbGenre, rating: Float) {
//        currentSearch = .Discover(year: year, genre: genre.rawValue, rating: rating)
//    }
//    
//    public func searchByTitle(query: String) {
//        currentSearch = .SearchByTitle(title: query)
//    }
//    
//    public func loadMore() {
//        guard state != .Loading else { return }
//        guard let currentSearch = currentSearch else { return }
//        guard let nextPage = searchResults.nextPage else { return }
//        
//        switch currentSearch {
//        case .Discover(let year, let genre, let rating):
//            discoverMoviesBy(year, genre: genre, rating: rating, page: nextPage)
//        case .SearchByTitle(let title):
//            fetchMoviesWithTitle(title, page: nextPage)
//        }
//    }
//    
//    private func fetchMoviesWithTitle(title: String, page: Int) {
//        state = .Loading
//        
//        movieClient.movieWithTitle(title, page: page) { (list, error) in
//            self.handleResponse(list: list, error: error)
//        }
//    }
//    
//    private func discoverMoviesBy(year: String, genre: Int, rating: Float, page: Int) {
//        state = .Loading
//        
//        movieClient.discover(year, genre: genre, vote: rating, page: page) { (list, error) in
//            self.handleResponse(list: list, error: error)
//        }
//        
//    }
//    
//    // MARK: Response
//    
//    private func handleResponse(list list: TMDbList<TMDbMovie>?, error: NSError?) {
//        guard error == nil else {
//            self.handleError(error!)
//            return
//        }
//        
//        if let results = list{
//            self.updateList(self.searchResults, withData: results)
//        }
//        
//    }
//     
//}
//
//
