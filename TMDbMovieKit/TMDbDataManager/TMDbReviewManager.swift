//
//  TMDbReviewManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public class TMDbReviewManager: TMDbListDataManager<TMDbReview> {
    
    // MARK: Properties
    
    public static let shared = TMDbReviewManager()
    
    public var movieID: Int?
    
    private let movieClient = TMDbMovieClient()
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: API Calls
    
    override func loadOnline(page: Int) {
        self.startLoading()
        
        guard let movieID = movieID else { return }
        
        movieClient.fetchReviews(movieID, page: page) { (list, error) in
            guard error == nil else {
                self.handleError(error!)
                return
            }
            
            if let data = list {
                self.update(withData: data)
            }
            
        }
    }
    
}
