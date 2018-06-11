//
//  AccountListDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class AccountListDataManager: ListDataManager<Movie> {
    
    // MARK: - Properties 
    
    let list: TMDbAccountList
    
    let sessionInfo: SessionInfoReading

    // MARK: - Initialize
    
    public convenience init(list: TMDbAccountList) {
        self.init(list: list, sessionInfo: SessionInfoService.shared)
    }
    
    init(list: TMDbAccountList, sessionInfo: SessionInfoReading) {
        self.list = list
        self.sessionInfo = sessionInfo
        super.init(refreshTimeOut: 0, cacheIdentifier: list.name)
    }

    // MARK: - Calls

    override func loadOnline() {
        assert(sessionInfo.user?.id != nil, "Error: Required userID for fetching the \(list.name) list is nil")
        assert(sessionInfo.sessionID != nil, "Error: Required sessionID for fetching the \(list.name) list is nil")
        let requestBuilder = RequestBuilder.accountList(userID: sessionInfo.user!.id, sessionID: sessionInfo.sessionID!, list: list, page: currentPage)
        makeRequest(builder: requestBuilder)
    }
}
