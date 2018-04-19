//
//  MovieController.swift
//  TMDbMovieKit
//
//  Created by Kaira  Diagne on 4/17/18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation

public class MovieListController: ListController<MovieObject> {
    
    // MARK: - Initialize
    
    public convenience init() {
        self.init(endpoint: "movie/popular")
    }
    
    // MARK: - Favorite
    
//    func markAsFavorite(movie: MovieObject, completion: (Result) -> Void) {
//        
//    }
}
