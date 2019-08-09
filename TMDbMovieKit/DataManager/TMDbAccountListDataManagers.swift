//
//  TMDbAccountListDataManagers.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public final class TMDbAccountListDataManager: ListDataManager<Movie> {
    
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
        let userID = sessionInfoStorage.user?.id ?? 1
        let sessionID = sessionInfoStorage.sessionID ?? ""
        super.init(request: ApiRequest.accountList(list, userID: userID, sessionID: sessionID), refreshTimeOut: 0, cacheIdentifier: list.name)
        subscribeForNotifications()
    }

    // MARK: - Notifications

    private func subscribeForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didLogOut), name: Notification.Name.SessionManager.didLogOut, object: nil)
    }

    @objc private func didLogOut() {
        clear()
    }
}
