//
//  MovieDBRequestAdapter.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 13/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Alamofire

/// Adapts requests that are intended for the Movie Database v3 and v4 API.
final class MovieDBRequestAdapter: RequestAdapter {

    // MARK: - Properties

    var apiKey: String {
        return DiscoverMoviesKit.shared.apiKey
    }

    var accessToken: String {
        // Later this should be either the readable api key or if access token is present that one.
        return DiscoverMoviesKit.shared.apiKey
    }

    // MARK: - RequestAdapter

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        guard let url = urlRequest.url else {
            return urlRequest
        }

        var urlRequest = urlRequest

        if url.absoluteURL.absoluteString.hasPrefix("https://api.themoviedb.org/4") {
            urlRequest.setValue("Bearer \(DiscoverMoviesKit.shared.readOnlyApiKey)", forHTTPHeaderField: "Authorization")
        } else if url.absoluteURL.absoluteString.hasPrefix("https://api.themoviedb.org/3") {
            let apiKeyQueryItem = URLQueryItem(name: "api_key", value: DiscoverMoviesKit.shared.apiKey)
            urlRequest.url = url.appending(queryItem: apiKeyQueryItem) ?? urlRequest.url
        }

        return urlRequest
    }
}
