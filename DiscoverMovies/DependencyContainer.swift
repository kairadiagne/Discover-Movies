//
//  DependencyContainer.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import TMDbMovieKit

final class DependencyContainer {

    // MARK: - Properties

    static let shared = DependencyContainer()

    private(set) var sessionManager = UserSessionManager()

    var persistentContainer: MovieKitPersistentContainer!

    private(set) var favoritesManager = AccountListDataManager(list: "favorite")

    private(set) var watchListManager = AccountListDataManager(list: "watchlist")
}
