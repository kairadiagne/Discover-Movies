//
//  APIService.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 27-05-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

enum APIResult<T: Codable> {
    case success(T)
    case failure(Error)
}

class APIService {

    // MARK: - Properties

    private let sessionManager: Alamofire.SessionManager

    private let errorHandler = APIErrorHandler()

    private let decoder = JSONDecoder()

    private let parseQueue = DispatchQueue(label: "com.discoverMovies.app.parse.serial", qos: .background)

    // MARK: - Initialize

    init(sessionManager: Alamofire.SessionManager = defaultManager) {
        self.sessionManager = sessionManager
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    // MARK: - Request

    func executeRequest<T: Codable>(builder: RequestBuilder, completion: @escaping (APIResult<T>) -> Void) {
        sessionManager.request(builder)
            .validate()
            .responseData(queue: parseQueue) { response in
                switch response.result {
                case .failure(let error):
                    let apiError = self.errorHandler.categorize(error: error)

                    DispatchQueue.main.async {
                        completion(.failure(apiError))
                    }
                case .success(let data):
                    do {
                        let object = try self.decoder.decode(T.self, from: data)

                        DispatchQueue.main.async {
                            completion(.success(object))
                        }
                    } catch {
                        let apiError = self.errorHandler.categorize(error: error)

                        DispatchQueue.main.async {
                            completion(.failure(apiError))
                        }
                    }
                }
        }
    }
}
