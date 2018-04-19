//
//  APIClient.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 16-04-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
    func get<T: Codable>(path: String, paramaters: [String: Any]?, body: [String: String]?, completion: @escaping (T) ->())
    func post(path: String, body: [String: String], completion: (Bool, Error) -> Void)
}

class APIClient: APIClientProtocol {

    // MARK: - Properties

    private let sessionManager: SessionManager

    // MARK: - Initialize

    init(sessionManager: SessionManager = SessionManager.default) {
        self.sessionManager = sessionManager
    }

    // MARK: - Get

    func get<T: Codable>(path: String, paramaters: [String: Any]?, body: [String: String]?, completion: @escaping (T) ->()) {
        let request = APIRequest.tmdbAPI(method: .get, path: path, paramaters: paramaters, body: body)

        sessionManager.request(request).validate().responseJSON { jsonResponse in
            print(jsonResponse)
        }
    }

    // MARK: - Post
    
    func post(path: String, body: [String : String], completion: (Bool, Error) -> Void) {
        let endpoint = APIRequest.tmdbAPI(method: .post, path: path, paramaters: nil, body: body)
        
        sessionManager.request(endpoint).validate().responseJSON { jsopnResponse in
            print(jsopnResponse)
        }
    }
}
