//
//  TMDbRequestToken.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

// TODO: - Make this clean

class TMDbRequestToken: NSObject, Mappable {
    
    var token: String = ""
    var expirationDate = ""
    
    init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
    if let token = response.result.value?["request_token"] as? String {
        self.requestToken = token
        let url = self.createAuthorizeURL(self.requestToken)
        completionHandler(url: url, error: nil)
    
    
}