//
//  TMDbMovieService.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// Completionhandlers
public typealias TMDbMovieCompletionHandler = (result: TMDbFetchResult<TMDbMovie>?, error: NSError?) -> ()
public typealias TMDbReviewCompletionHandler = (result: TMDbFetchResult<TMDbReview>?, error: NSError?) -> ()
public typealias TMDbVideosCompletionHandler = (result: [TMDbVideo]?, error: NSError?) -> ()

// Response 
typealias MovieResponse = Response<TMDbFetchResult<TMDbMovie>, NSError>

public class TMDbMovieService {
    
    public init() { }
    
    // MARK: - Fetch Lists of Movies
    
    public func fetchTopList(list: String, page: Int?, completionHandler: TMDbMovieCompletionHandler) {
        Alamofire.request(TMDbMovieRouter.TopList(list, page)).validate().responseResult { (response: MovieResponse) in
            completionHandler(result: response.result.value, error: response.result.error)
        }
    }
    
    public func discoverMovies(year: String?, genre: Int?, voteAverage: Float?, page: Int?, completionHandler: TMDbMovieCompletionHandler) {
        Alamofire.request(TMDbMovieRouter.Discover(year, genre, voteAverage, page)).validate().responseResult { (response: MovieResponse) in
            completionHandler(result: response.result.value, error: response.result.error)
        }
    }
    
    public func searchForMovieWith(title: String, page: Int?, completionHandler: TMDbMovieCompletionHandler) {
        Alamofire.request(TMDbMovieRouter.SearchByTitle(title, page)).validate().responseResult { (response: MovieResponse) in
            completionHandler(result: response.result.value, error: response.result.error)
        }
    }
    
    public func fetchMoviesSimilarToMovie(withID id: Int, page: Int?, completionHandler: TMDbMovieCompletionHandler) {
        Alamofire.request(TMDbMovieRouter.SimilarMovies(id, page)).validate().responseResult { (response: MovieResponse) in
            completionHandler(result: response.result.value, error: response.result.error)
        }
    }
    
    // MARK: - Fetch Additional info About Movie
    
    public func fetchTrailerForMovie(movieID: Int, completionHandler: TMDbVideosCompletionHandler) {
        Alamofire.request(TMDbMovieRouter.Videos(movieID)).validate().responseArray("results") { (response: Response<[TMDbVideo], NSError>) in
            completionHandler(result: response.result.value, error: response.result.error)
        }
    }
    
    public func fetchReviews(movieID: Int, page: Int?, completionHandler: TMDbReviewCompletionHandler) {
        Alamofire.request(TMDbMovieRouter.Reviews(movieID, page)).validate().responseResult { (response) in
            completionHandler(result: response.result.value, error: response.result.error)
        }
    }
    
}


