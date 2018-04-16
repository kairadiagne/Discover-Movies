//
//  AlamofireDataRequest+DictionarySerializable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    
    @discardableResult
    func responseObject<T: DictionarySerializable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            
            guard error == nil else {
                return .failure(APIErrorHandler.categorize(error: error!))
            }
            
            // Parse respone as JSON
            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
            
            // Create model objects
            guard case let .success(jsonObject) = result else {
                return .failure(APIErrorHandler.categorize(error: result.error!))
            }
            
            guard let responseDict = jsonObject as? [String: AnyObject], let responseObject = T(dictionary: responseDict) else {
                return .failure(APIError.generic)
            }
            
            return .success(responseObject)
        }
        
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
