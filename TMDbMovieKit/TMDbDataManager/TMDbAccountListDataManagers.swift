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
    
    // MARK: - Properties
    
    var userID: Int? {
       return TMDbSessionInfoStore().user?.id
    }
    
    // MARK: - Initialize
    
    private init(list: TMDbListType, cacheIdentifier: String) {
        super.init(list: list, cacheIdentifier: cacheIdentifier, writesDataToDisk: true)
    }

    // MARK: - Endpoint
    
    override func endpoint() -> String {
        return "account/\(userID)/\(list.name)/movies"
    }

    // MARK: - Paramaters
    
    override func defaultParamaters() -> [String : AnyObject] {
        guard let sessionID = sessionInfoProvider.sessionID else { return [:] } 
        return ["session_id": sessionID]
    }
    
}

// MARK: - TMDbFavoritesListDataManager

public class TMDbFavoritesListDataManager: TMDbAccountListDataManager {
    
    public static let shared = TMDbFavoritesListDataManager(list: TMDbAccountList.Favorite, cacheIdentifier: TMDbAccountList.Favorite.name)
    
}

// MARK: - TMDbWatchListDataManager

public class TMDbWatchListDataManager: TMDbAccountListDataManager {
    
    public static let shared = TMDbWatchListDataManager(list: TMDbAccountList.Watchlist, cacheIdentifier: TMDbAccountList.Watchlist.name)
    
}



