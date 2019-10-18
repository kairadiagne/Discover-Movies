//
//  DependencyContainer.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import TMDbMovieKit

struct DependencyContainer {

    // MARK: - Properties

    static let shared = DependencyContainer()

    private(set) var sessionManager = UserSessionManager()

    private(set) var popularListManager = TopListDataManager(list: .popular)

    private(set) var nowPlayingListManager = TopListDataManager(list: .nowPlaying)

    private(set) var topratedListManager = TopListDataManager(list: .topRated)

    private(set) var upcomingListManager = TopListDataManager(list: .upcoming)

    private(set) var favoritesManager = AccountListDataManager(list: .favorite)

    private(set) var watchListManager = AccountListDataManager(list: .watchlist)
}
