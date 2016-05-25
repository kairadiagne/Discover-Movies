//
//  TMDbSessionID.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

class TMDbSessionID: NSObject, Mappable {
    
    var sessionID: String = ""
    var timeStamp : NSDate = NSDate()
    
    init?(_ map: Map) {    }
    
    func mapping(map: Map) {
    
    }
    
}
