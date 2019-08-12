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

    private(set) var sessionManager = TMDbSessionManager()

    private(set) var popularListManager = TMDbTopListDataManager(list: .popular)

    private(set) var nowPlayingListManager = TMDbTopListDataManager(list: .nowPlaying)

    private(set) var topratedListManager = TMDbTopListDataManager(list: .topRated)

    private(set) var upcomingListManager = TMDbTopListDataManager(list: .upcoming)

    private(set) var favoritesManager = TMDbAccountListDataManager(list: .favorite)

    private(set) var watchListManager = TMDbAccountListDataManager(list: .watchlist)
}
