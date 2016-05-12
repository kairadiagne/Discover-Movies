//
//  TMDbSessionManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

// TODO: - Advanced Error Handling

import Foundation
import Locksmith

public class TMDbSessionManager {
    
    public init() { }
    
    let sessionInfoStore = TMDbSessionInfoStore()
    
    public func registerAPIKey(APIKey key: String) {
        sessionInfoStore.APIKey = key
    }
    
}







