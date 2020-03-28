//
//  MovieDBRequestAdapter.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 13/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Alamofire

/// Adapts requests to the Movie Database API with an access token.
final class MovieDBRequestAdapter: RequestInterceptor {
    
    // MARK: Properties
    
    /// The access token which provides read only access to the Movie Database v3 and v4 API.
    let apiReadOnlyAccessToken: String
    
    private let accessTokenStore: AccessTokenManaging

    // MARK: Initialize

    init(accessTokenStore: AccessTokenManaging, readOnlyAccessToken: String) {
        self.accessTokenStore = accessTokenStore
        self.apiReadOnlyAccessToken = readOnlyAccessToken
    }

    // MARK: RequestAdapter
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let url = urlRequest.url, url.absoluteString.hasPrefix("https://api.themoviedb.org/") else {
            completion(.success(urlRequest))
            return
        }

        let accessToken = accessTokenStore.cachedAccessToken ?? apiReadOnlyAccessToken
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: accessToken))
        completion(.success(urlRequest))
    }
}
