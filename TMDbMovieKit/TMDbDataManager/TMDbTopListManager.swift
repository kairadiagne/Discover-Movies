//
//  DataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public enum TMDbToplist: String {
    case Popular = "popular"
    case TopRated = "top_rated"
    case Upcoming = "upcoming"
    case NowPlaying = "now_playing"
}

public class TMDbTopListManager {
    
    // Public properties
    
    public var movies: [TMDbMovie] {
        guard let currentList = currentList else { return [] }
        
        switch currentList {
        case .Popular:
            return popular.items
        case .TopRated:
            return topRated.items
        case .Upcoming:
            return upcoming.items
        case .NowPlaying:
            return nowPlaying.items
        }
        
    }
    
    public var inProgress: Bool = false
    
    // Private properties
    
    private let movieService = TMDbMovieService()
    
    private var currentList: TMDbToplist?
    
    private var popular = TMDbListHolder<TMDbMovie>()
    
    private var topRated = TMDbListHolder<TMDbMovie>()
    
    private var upcoming = TMDbListHolder<TMDbMovie>()
    
    private var nowPlaying = TMDbListHolder<TMDbMovie>()
    
    // MARK: - Initialization 
    
    public init () { }  
    
    // MARK: - Fetching

    public func reloadTopIfNeeded(forceOnline: Bool, list: TMDbToplist) {
        // For know I let NSURLCache handle the caching
        currentList = list
        inProgress = true
        fetchList(list, page: 1)
    }
    
    public func loadMore() {
        guard inProgress == false else { return }
        guard let list = currentList else { return }
    
        // Check which page we need to fetch
        var page: Int?
        
        switch list {
        case .Popular:
            page = popular.nextPage
        case .TopRated:
            page = topRated.nextPage
        case .NowPlaying:
            page = nowPlaying.nextPage
        case .Upcoming:
            page = upcoming.nextPage
        }
        
        fetchList(list, page: page)
    }
    
    // MARK: Fetching
    
    private func fetchList(list: TMDbToplist, page: Int) {
        guard let currentList = currentList else { return }
        
        let urlString = "movie/\(list.rawValue)"
        let parameters: [String: AnyObject] = ["page": page]
        
        
        
        Alamofire.request(.GET, <#T##URLString: URLStringConvertible##URLStringConvertible#>, parameters: <#T##[String : AnyObject]?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##[String : String]?#>)
        
        
        
        
        
        
        switch self {
        case .TopList(let list, let page, let APIKey):
            if let page = page { parameters[Key.Page] = page }
            parameters[Key.APIKey] = APIKey
            return ("movie/\(list)", parameters)
        case .Discover(let year, let genre, let voteAverage, let page, let APIKey):
            if let year = year { parameters[Key.ReleaseYear] = year }
            if let genre = genre { parameters[Key.Genre] = genre }
            if let voteAverage = voteAverage { parameters[Key.Vote] = voteAverage }
            if let page = page { parameters[Key.Page] = page }
            parameters[Key.Sort] = "popularity.desc"
            parameters[Key.APIKey] = APIKey
            return ("discover/movie", parameters)
        case .SearchByTitle(let title, let page, let APIKey):
            parameters[Key.Query] = title
            if let page = page { parameters[Key.Page] = page }
            parameters[Key.APIKey] = APIKey
            return ("search/movie", parameters)
        case .List(let list, let sessionID, let accountID, let page, let APIKey):
            parameters[Key.SessionID] = sessionID
            if let page = page { parameters[Key.Page] = page }
            parameters[Key.APIKey] = APIKey
            return ("account/\(accountID)/\(list)/movies", parameters)
        case .SimilarMovies(let movieID, let page, let APIKey):
            if let page = page { parameters[Key.Page] = page }
            parameters[Key.APIKey] = APIKey
            return ("movie/\(movieID)/similar", parameters)
        case .MovieCredits(let movieID, let APIKey):
            parameters[Key.APIKey] = APIKey
            return ("movie/\(movieID)/credits", parameters)
        case .Reviews(let movieID, let page, let APIKey):
            if let page = page { parameters[Key.Page] = page }
            parameters[Key.APIKey] = APIKey
            return ("movie/\(movieID)/reviews", parameters)
        case .Videos(let movieID, let APIKey):
            parameters[Key.APIKey] = APIKey
            return ("movie/\(movieID)/videos", parameters)
        case .AccountState(let movieID, let sessionID, let APIKey):
            parameters[Key.SessionID] = sessionID
            parameters[Key.APIKey] = APIKey
            return ("movie/\(movieID)/account_states", parameters)
        case .AddRemoveFromList(_, let accountID, let list, let sessionID, let APIKey):
            parameters[Key.SessionID] = sessionID
            parameters[Key.APIKey] = APIKey
            return("account/\(accountID)/\(list)", parameters)
        }
    }()
    
        Alamofire.request(<#T##URLRequest: URLRequestConvertible##URLRequestConvertible#>)
    
        i
//        func fetchToplist(list: String, page: Int?, completionHandler: MovieListCompletionHandler) {
//            Alamofire.request(TMDbMovieRouter.TopList(list: list, page: page, APIKey: APIKey)).validate()
//                .responseObject { (response: MovieListResponse) in
//                    completionHandler(result: response.result.value, error: response.result.error)
//            }
//        }
        
        
        movieService.fetchTopList(list.rawValue, page: page, completionHandler: { (result, error) in
            self.inProgress = false
            guard error == nil else {
                self.postErrorNotification(error!)
                return
            }
            
            if let data = result {
                switch currentList {
                case .Popular:
                    self.updateList(self.popular, withData: data)
                case .TopRated:
                    self.updateList(self.topRated, withData: data)
                case .Upcoming:
                    self.updateList(self.upcoming, withData: data)
                case .NowPlaying:
                    self.updateList(self.nowPlaying, withData: data)
                }

            }
        })
    }
    
    // MARK: - Handle Response
    
    private func updateList(list: TMDbListHolder<TMDbMovie>, withData data: TMDbListHolder<TMDbMovie>) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
           list.update(data)

            dispatch_async(dispatch_get_main_queue(), {
                if list.page == 1 {
                    self.postUpdateNotification()
                } else if list.page > 1 {
                    self.postChangeNotification()
                }
            })
        }
    }
 
    
    // MARK: - Notifications
    
    private func postUpdateNotification() {
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(TMDbManagerDataDidUpdateNotification, object: self)
    }
    
    private func postChangeNotification() {
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(TMDManagerDataDidChangeNotification, object: self)
    }
    
    private func postErrorNotification(error: NSError) {
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(TMDbManagerDidReceiveErrorNotification, object: self, userInfo: ["error": error])
    }
    
}

    





