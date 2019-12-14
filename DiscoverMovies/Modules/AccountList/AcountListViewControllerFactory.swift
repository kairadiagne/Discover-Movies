//
//  AcountListViewControllerFactory.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

struct AcountListViewControllerFactory {

    static func createFavorites(with container: DependencyContainer) -> AccountListController {
        return AccountListController(list: "favorite", manager: container.favoritesManager)
    }

    static func createWatchList(with container: DependencyContainer) -> AccountListController {
        return AccountListController(list: "watchlist", manager: container.watchListManager)
    }

}
