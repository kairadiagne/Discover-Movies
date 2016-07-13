//
//  TMDbReviewManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public class TMDbReviewManager: TMDbBaseDataManager {
    
    public var reviews: [TMDbReview] {
        return reviewList.items
    }

    private let movieClient = TMDbMovieClient()
    private var reviewList = TMDbList<TMDbReview>()
    private var movieID: Int?
    
    // MARK: - API Calls
    
    public func loadReviews(movieID: Int) {
        self.movieID = movieID
        fetchReviews(movieID, page: 1)
    }
    
    public func loadMore() {
        guard state != .Loading else { return }
        guard let movieID = movieID else { return }
        guard let nextPage = reviewList.nextPage else { return }
        fetchReviews(movieID, page: nextPage)
    }
    
    private func fetchReviews(movieID: Int, page: Int) {
        movieClient.fetchReviews(movieID, page: page) { (list, error) in
            guard error == nil else  {
                self.handleError(error!)
                return
            }
            
            if let result = list {
                self.updateList(self.reviewList, withData: result)
            }
        }
    }
    
}
