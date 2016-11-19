//
//  TMDbAccountListDataManagers.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbAccountListDataManager: ListDataManager<Movie> {
    
    // MARK: - Properties 
    
    let list: TMDbAccountList
    
    let sessionInfoProvider: SessionInfoContaining

    // MARK: - Initialize
    
    public init(list: TMDbAccountList) {
        self.list = list
        self.sessionInfoProvider = TMDbSessionInfoStore()
        super.init(configuration: AccountListConfiguration(list: list), refreshTimeOut: 0, cacheIdentifier: list.name)
    }

}


