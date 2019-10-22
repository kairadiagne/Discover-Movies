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
    
    private let sessionInfoStorage: SessionInfoContaining

    // MARK: - Initialize
    
    public convenience init(list: TMDbAccountList) {
        let sessionInfoStorage = SessionInfoStorage(keyValueStorage: UserDefaults.standard)
        self.init(list: list, sessionInfoProvider: sessionInfoStorage)
    }
    
    init(list: TMDbAccountList, sessionInfoProvider: SessionInfoContaining) {
        self.list = list
        self.sessionInfoStorage = sessionInfoProvider
//        let userID = sessionInfoStorage.user?.identifier ?? 1
        let userID = 1
        let sessionID = sessionInfoStorage.sessionID ?? ""
        super.init(request: ApiRequest.accountList(list, userID: userID, sessionID: sessionID), refreshTimeOut: 0, cacheIdentifier: list.name)
    }
}
