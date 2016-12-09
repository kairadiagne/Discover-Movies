//
//  RequestConfigurations.swift
//  Discover
//
//  Created by Kaira Diagne on 19-11-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - RequestConfiguration

protocol RequestConfiguration {
    var method: HTTPMethod { get }
    var endpoint: String { get }
    var defaultParams: [String: AnyObject]? { get }
    var headers: HTTPHeaders? { get }
}

extension RequestConfiguration {
    
    var defaultParams: [String: AnyObject]? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}

// MARK: - Authentication Configurations

struct RequestTokenConfiguration: RequestConfiguration {
    let method: HTTPMethod = .get
    
    var endpoint: String {
        return "authentication/token/new"
    }
}

struct RequestSessionTokenConfiguration: RequestConfiguration {
    let method: HTTPMethod = .get
    
    var endpoint: String {
        return "authentication/session/new"
    }
}

struct UserConfiguration: RequestConfiguration {
    let method: HTTPMethod = .get
    
    var endpoint: String {
        return "account"
    }
}

// MARK: - MovieListConfigurations

struct TopListRequestConfiguration: RequestConfiguration {
    let list: TMDbList
    let method: HTTPMethod = .get
    
    var endpoint: String {
        return "movie/\(list.name)"
    }
    
}

struct AccountListConfiguration: RequestConfiguration {
    let list: TMDbList
    let infoStore = TMDbSessionInfoStore()
    let method = HTTPMethod.get
    
    var endpoint: String {
        guard let userID = infoStore.sessionID else { return "" }
        return "account/\(userID)/\(list.name)/movies"
    }
    
    var defaultParams: [String : AnyObject]? {
        guard let sessionID = infoStore.sessionID else { return [:] }
        return ["session_id": sessionID as AnyObject]
    }
}

struct SimilarMoviesRequestConfiguration: RequestConfiguration {
    let method: HTTPMethod = .get
    let movieID: Int
    
    var endpoint: String {
        return "movie/\(movieID)/similar"
    }
}

struct SearchRequestConfiguration: RequestConfiguration {
    let method: HTTPMethod = .get
    
    var endpoint: String {
        return "search/movie"
    }
}

// MARK: - MovieInfo Configurations

struct MovieDetailConfiguration: RequestConfiguration {
    let method: HTTPMethod = .get
    let movieID: Int
    
    var endpoint: String {
        return "movie/\(movieID)"
    }
    
    var defaultParams: [String : AnyObject]? {
        return ["append_to_response": "credits,trailers" as AnyObject]
    }
}


struct ReviewRequestConfiguration: RequestConfiguration {
    let method: HTTPMethod = .get
    let movieID: Int
    
    var endpoint: String {
        return "movie/\(movieID)/reviews"
    }
}


struct AccountStateConfiguration: RequestConfiguration {
    let method: HTTPMethod = .get
    let movieID: Int
    
    var endpoint: String {
        return "movie/\(movieID)/account_states"
    }
}

struct ListStatusConfiguration: RequestConfiguration {
    let method: HTTPMethod = .post
    let userID: Int
    let list: TMDbAccountList
    
    var endpoint: String {
        return "account/\(userID)/\(list.name)"
    }
}



