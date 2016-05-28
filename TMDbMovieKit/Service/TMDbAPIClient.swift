//
//  TMDbAPIClient.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

class TMDbAPIClient {
    
    // MARK: - Initialization
    
    init() { }
    
    // MARK: - Properties
    
    private let infoStore = TMDbSessionInfoStore()

    var APIKey: String {
        return infoStore.APIKey
    }
    
    var sessionID: String? {
        return infoStore.sessionID
    }
    
    var userID: Int? {
        return infoStore.user?.userID
    }
    
}





    


    









