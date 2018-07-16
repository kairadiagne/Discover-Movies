//
//  AppDependency.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 08-07-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import TMDbMovieKit

struct AppDependency {
    let authenticationManager: AuthenticationManager
    let userDataManager: UserDataManager
    let popularListManager: TopListDataManager
    let nowPlayingListManager: TopListDataManager
    let topratedListManager: TopListDataManager
    let upcomingListManager: TopListDataManager
    let favoritesManager: AccountListDataManager
    let watchListManager: AccountListDataManager
}
