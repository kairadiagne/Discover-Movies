//
//  AccountListDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public final class AccountListDataManager: ListDataManager<Movie> {
    
    // MARK: - Properties 
    
    private let list: TMDbAccountList
    
    private let sessionInfoStorage: AccessTokenManaging

    // MARK: - Initialize
    
    public convenience init(list: TMDbAccountList) {
        let sessionInfoStorage = AccessTokenStore()
        self.init(list: list, sessionInfoProvider: sessionInfoStorage)
    }
    
    init(list: TMDbAccountList, sessionInfoProvider: AccessTokenManaging) {
        self.list = list
        self.sessionInfoStorage = sessionInfoProvider
        let userID = 1
        let sessionID = sessionInfoStorage.accessToken ?? ""
        super.init(request: ApiRequest.accountList(list, userID: userID, sessionID: sessionID), refreshTimeOut: 0, cacheIdentifier: list.name)
    }
}
