//
//  URL+AppendQueryItem.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 13/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

extension URL {

    /// Adds or appends a given `URLQueryItem` to the query string of the URL.
    /// - Parameter queryItem: The query item to append to the URL.
    func appending(queryItem: URLQueryItem) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }

        if urlComponents.queryItems != nil {
            urlComponents.queryItems?.append(queryItem)
        } else {
            urlComponents.queryItems = [queryItem]
        }

        return urlComponents.url
    }
}
