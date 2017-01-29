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
    
    public convenience init(list: TMDbAccountList) {
        self.init(list: list, sessionInfoProvider: TMDbSessionInfoStore())
    }
    
    init(list: TMDbAccountList, sessionInfoProvider: SessionInfoContaining) {
        self.list = list
        self.sessionInfoProvider = sessionInfoProvider
        super.init(configuration: AccountListConfiguration(list: list), refreshTimeOut: 0, cacheIdentifier: list.name)
    }

}
