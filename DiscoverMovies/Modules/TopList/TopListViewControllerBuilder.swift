//
//  TopListViewControllerBuilder.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit

struct TopListViewControllerFactory {

    static func create(with container: DependencyContainer) -> TopListViewController {
        return TopListViewController(popularListManager: container.popularListManager,
                                                     nowPlayingListManager: container.nowPlayingListManager,
                                                     topRatedListManager: container.topratedListManager,
                                                     upcomingListManager: container.upcomingListManager,
                                                     signedIn: container.sessionManager.signInStatus == .signedin)
    }
}
