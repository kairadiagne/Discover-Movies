//
//  TMDbAccountListDataManagers.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

// MARK: TMDbAccountListDataManager

public class TMDbAccountListDataManager: TMDbListDataManager<Movie> {
    
    // MARK: Properties
    
    var userID: Int? {
       return TMDbSessionInfoStore().user?.id
    }
    
    var sessionID: String? {
        return TMDbSessionInfoStore().sessionID
    }
    
    override var endpoint: String {
        return "account/\(userID)/\(list.name)/movies"
    }
    
    // MARK: Initialize
    
    override init(list: TMDbListType, cacheIdentifier: String) {
        super.init(list: list, cacheIdentifier: cacheIdentifier)
    }

    // MARK: Paramaters
    
    override func getParameters() -> [String : AnyObject] {
        var paramaters = super.getParameters()
        paramaters["session_id"] = sessionID
        return paramaters
    }
    
}


