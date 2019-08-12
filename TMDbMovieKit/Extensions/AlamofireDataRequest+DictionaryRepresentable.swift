//
//  AlamofireDataRequest+Codable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    
    @discardableResult
    func responseObject<T: Codable>(decoder: JSONDecoder = JSONDecoder(), queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            
            guard error == nil else {
                return .failure(APIErrorHandler.categorize(error: error!))
            }
            
            // Parse respone as JSON
            let dataResponseSerializer = DataRequest.dataResponseSerializer()
            let result = dataResponseSerializer.serializeResponse(request, response, data, nil)
            
            // Create model objects
            switch result {
            case .success(let data):
                return .failure(APIError.generic)
                do {
                    let object = try decoder.decode(T.self, from: data)
                    return .success(object)
                } catch {
                    print(error)
                    return .failure(APIError.generic)
                }

            case .failure(let error):
                return .failure(APIErrorHandler.categorize(error: error))
            }
        }
        
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
