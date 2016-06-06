//
//  TMDbReviewManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public class TMDbReviewManager: TMDbDataManager {
    
    public var inProgress = true
    
    public var reviews: [TMDbReview] {
        return reviewList.items
    }

    private let movieClient = TMDbMovieClient()
    
    private var movieID: Int?
    
    private var reviewList = TMDbList<TMDbReview>()
    
    // MARK: - Initialization 
    
    public init() { }
    
    // MARK: - Fetching 
    
    public func loadReviews(movieID: Int) {
        self.movieID = movieID
        fetchReviews(movieID, page: 1)
    }
    
    public func loadMore() {
        guard let movieID = movieID else { return }
        guard let nextPage = reviewList.nextPage else { return }
        fetchReviews(movieID, page: nextPage)
    }
    
    private func fetchReviews(movieID: Int, page: Int) {
        movieClient.fetchReviews(movieID, page: page) { (response: Result<TMDbList<TMDbReview>, NSError>) in
            
            guard response.error == nil else {
                self.postErrorNotification(response.error!)
                return
            }
            
            if let reviewList = response.value {
                self.updateList(self.reviewList, withData: reviewList)
            }
        }
    }
    
    // MARK: - Handle Response 
    
    private func updateList(list: TMDbList<TMDbReview>, withData data: TMDbList<TMDbReview>) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            list.update(data)
            
            dispatch_async(dispatch_get_main_queue()) {
                if list.page == 1 {
                    self.postUpdateNotification()
                } else if list.page > 1 {
                    self.postChangeNotification()
                }
            }
        }
    }
    
}
