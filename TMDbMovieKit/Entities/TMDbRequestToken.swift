//
//  TMDbRequestToken.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

class TMDbRequestToken: NSObject, Mappable {
    
    var token: String = ""
    var expirationDate = NSDate()
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        self.token              <- map["request_token"]
        self.expirationDate     <- (map["expires_at"], DateTransform())
    }

}