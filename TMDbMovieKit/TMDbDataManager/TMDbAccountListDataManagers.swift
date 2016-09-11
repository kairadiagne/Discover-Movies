//
//  TMDbAccountListDataManagers.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbAccountListDataManager: PagingDataManager<Movie> {
    
    // MARK: - Properties 
    
    let list: TMDbAccountList
    
    // MARK: - Initialize
    
    public init(list: TMDbAccountList) {
        self.list = list
        super.init(identifier: list.name, sessionInfoProvider: TMDbSessionInfoStore(), writesToDisk: true, refreshTimeOut: 300)
    }

    // MARK: - Endpoint
    
    override func endpoint() -> String {
        guard let userID = sessionInfoProvider.sessionID else { return "" }
        return "account/\(userID)/\(list.name)/movies"
    }

    // MARK: - Paramaters
    
    override func defaultParamaters() -> [String : AnyObject] {
        guard let sessionID = sessionInfoProvider.sessionID else { return [:] } 
        return ["session_id": sessionID as AnyObject]
    }
    
}


