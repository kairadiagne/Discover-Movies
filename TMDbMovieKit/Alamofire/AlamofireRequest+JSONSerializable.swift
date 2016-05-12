//
//  AlamofireRequest+JSONSerializable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 14-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension Alamofire.Request {
    
    public func responseResult<T: JSONSerializable>(completionHandler: Response<TMDbListHolder<T>, NSError> -> Void) -> Self {
        let serializer = ResponseSerializer<TMDbListHolder<T>, NSError> { request, response, data, error in
            guard error == nil else {
                return .Failure(error!)
            }
            
            guard let responseData = data else {
                let failureReason = "Object could not be serialized because input data was nil."
                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                return .Failure(error)
            }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, responseData, error)
            
            switch result {
            case .Success(let value):
                let json = SwiftyJSON.JSON(value)
                if let fetchResult = TMDbListHolder<T>(json: json) {
                    return .Success(fetchResult)
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
    
    public func responseArray<T: JSONSerializable>(key: String, completionHandler: Response<[T], NSError> -> Void) -> Self {
        let serializer = ResponseSerializer<[T], NSError> { request, response, data, error in
            guard error == nil else {
                return .Failure(error!)
            }
            guard let responseData = data else {
                let failureReason = "Object could not be serialized because input data was nil."
                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                return .Failure(error)
            }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, responseData, error)
            
            switch result {
            case .Success(let value):
                let json = SwiftyJSON.JSON(value)
                var objects: [T] = []
                for (_, item) in json[key] {
                    if let object = T(json: item) {
                        objects.append(object)
                    }
                }
                return .Success(objects)
            case .Failure(let error):
                return .Failure(error)
            }
        }
        return response(responseSerializer: serializer, completionHandler: completionHandler)
    }
    
    public func responseObject<T: JSONSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
        let serializer = ResponseSerializer<T, NSError> { request, response, data, error in
            guard error == nil else {
                return .Failure(error!)
            }
            guard let responseData = data else {
                let failureReason = "Object could not be serialized because input data was nil."
                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                return .Failure(error)
            }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, responseData, error)
            
            switch result {
            case .Success(let value):
                let json = SwiftyJSON.JSON(value)
                if let object = T(json: json) {
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

