//
//  PeopleDataManager.swift
//  Discover
//
//  Created by Kaira Diagne on 03-12-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public class PeopleManager: ListDataManager<Person> {
    
    public init() {
        super.init(configuration: PopularPeopleConfig(), refreshTimeOut: 60, cacheIdentifier: "PeopleCache")
    }
    
}

public struct Person: DictionarySerializable   {
    let id: Int
    let name: String
    let path: String
    
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let id = dict["id"] as? Int, let name = dict["name"] as? String, let path = dict["profile_path"] as? String else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.path = path
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        var dict: [String: AnyObject] = [:]
        dict["id"] = id as AnyObject?
        dict["name"] = name as AnyObject?
        dict["profile_path"] = path as AnyObject?
        return dict
    }
}

// People

struct PopularPeopleConfig: RequestConfiguration {
    let method: HTTPMethod = .get
    var endpoint: String {
        return "person/popular"
    }
    
}
