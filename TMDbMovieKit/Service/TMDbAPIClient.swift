//
//  TMDbAPIClient.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

class TMDbAPIClient {

    var APIKey: String {
        return TMDbSessionInfoStore().APIKey
    }
    
    var sessionID: String? {
        return TMDbSessionInfoStore().sessionID
    }
    
    var userID: Int? {
        return TMDbSessionInfoStore().user?.userID
    }
    
}





    


    









