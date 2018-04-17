//
//  APIClient.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 16-04-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {

    // MARK: - Properties

    private let sessionManager: SessionManager

    // MARK: - Initialize

    init(sessionManager: SessionManager = SessionManager.default) {
        self.sessionManager = sessionManager
    }

    // MARK: - Get

    func get<T: Codable>(path: String, paramaters: [String: Any]?, body: [String: Any]?, completion: @escaping (T) ->() ) {
        let request = APIRequest.tmdbAPI(method: .get, path: path, paramaters: paramaters, body: body)

        sessionManager.request(request).validate().responseJSON { jsonResponse in
            print(jsonResponse)
        }
    }

    // MARK: - Post
}
