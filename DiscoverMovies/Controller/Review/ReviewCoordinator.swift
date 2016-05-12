////
////  ReviewCoordinator.swift
////  DiscoverMovies
////
////  Created by Kaira Diagne on 17-04-16.
////  Copyright © 2016 Kaira Diagne. All rights reserved.
////
//
//import Foundation
//import TMDbMovieKit
//
//class ReviewCoordinator: ItemCoordinator<TMDbReview> {
//    
//    private let movieService: TMDbMovieService!
//    private var movieID: Int?
//    
//    override init() {
//        self.movieService = TMDbMovieService(APIKey: Global.APIKey)
//    }
//    
//    // MARK: - Service Calls
//    
//    func fetchReviews(movieID: Int) {
//        self.movieID = movieID
//        fetchReviewsForMovieWithID(movieID, page: 1)
//    }
//    
//    override func fetchNextPage() {
//        guard let movieID = movieID else { return }
//        fetchReviewsForMovieWithID(movieID, page: nextPage)
//    }
//    
//    private func fetchReviewsForMovieWithID(movieID: Int, page: Int?) {
//        movieService.fetchReviews(movieID, page: page) { (response) in
//            self.handleResponse(response)
//        }
//    }
//    
//}
//
//
//
//
