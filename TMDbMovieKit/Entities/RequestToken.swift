//
//  RequestToken.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

struct RequestToken: DictionarySerializable {
    
    // MARK: - Properties
    
    let token: String
    
    // MARK: - Initialize
    
    init?(dictionary dict: [String : AnyObject]) {
        guard let token = dict["request_token"] as? String else { return nil }
        self.token = token
    }
    
    func dictionaryRepresentation() -> [String : AnyObject] {
        return ["request_token": token as AnyObject]
    }
}
