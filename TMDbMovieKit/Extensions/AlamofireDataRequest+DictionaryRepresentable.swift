//
//  AlamofireDataRequest+DictionaryRepresentable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    
    @discardableResult
    func responseObject<T: DictionaryRepresentable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            // Parse respone as JSON
            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
            
            // Create model objects
            guard case let .success(jsonObject) = result else {
                let error = NSError() //Error
                return .failure(error)
            }
            
            guard let responseDict = jsonObject as? [String: AnyObject], let responseObject = T(dictionary: responseDict) else {
                let error = NSError() // Error
                return .failure(error)
            }
            
            return .success(responseObject)
        }
        
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }

}


