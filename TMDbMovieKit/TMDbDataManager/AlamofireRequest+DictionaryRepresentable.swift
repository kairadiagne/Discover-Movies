//
//  AlamofireRequest+DictionaryRepresentable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public extension Alamofire.Request {
    
    public func responseObject<T: DictionaryRepresentable>(completionHandler: Response<T, NSError> -> Void) -> Self {
        let serializer = ResponseSerializer<T, NSError> { request, response, data, error in
            
            // Return in case of error
            guard error == nil else {
                return .Failure(error!)
            }
            
            // Unwrap the responsedata
            guard let responseData = data else {
                let failureReason = "Object could not be serialized because input data was nil."
                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                return .Failure(error)
            }
            
            // Parse as JSON
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, responseData, error)
            
            // Convert JSON into object
            switch result {
            case .Success(let value):
                if let dict = value as? [String: AnyObject], object = T(dictionary: dict) {
                    return .Success(object)
                } else {
                    let failureReason = "Object could not be created from JSON."
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        return response(responseSerializer: serializer, completionHandler: completionHandler)
    }
    
}




