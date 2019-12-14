//
//  TopListViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import CoreUIElements
import TMDbMovieKit

final class TopListViewController: SegmentedViewController {

    // MARK: - Initialize

    init(persistentContainer: MovieKitPersistentContainer) {
        let popular = MovieListViewController(dataProvider: MovieListDataProvider(listType: .popular, persistentContainer: persistentContainer), titleString: "popular".localized, signedIn: false)
        let nowPlaying = MovieListViewController(dataProvider: MovieListDataProvider(listType: .nowPlaying, persistentContainer: persistentContainer), titleString: "nowPlaying".localized, signedIn: false)
        let topRated = MovieListViewController(dataProvider: MovieListDataProvider(listType: .topRated, persistentContainer: persistentContainer), titleString: "topRated".localized, signedIn: false)
        let upcoming = MovieListViewController(dataProvider: MovieListDataProvider(listType: .upcoming, persistentContainer: persistentContainer), titleString: "upcoming".localized, signedIn: false)
        super.init(viewControllers: [popular, nowPlaying, topRated, upcoming], title: "topListVCTitle".localized)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
