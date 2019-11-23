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
    
    init(popularListManager: TopListDataManager,
         nowPlayingListManager: TopListDataManager,
         topRatedListManager: TopListDataManager,
         upcomingListManager: TopListDataManager,
         signedIn: Bool) {
        
        let topListVCs = [MovieListViewController(dataManager: popularListManager, titleString: "popular".localized, signedIn: signedIn),
                          MovieListViewController(dataManager: nowPlayingListManager, titleString: "nowPlaying".localized, signedIn: signedIn),
                          MovieListViewController(dataManager: topRatedListManager, titleString: "topRated".localized, signedIn: signedIn),
                          MovieListViewController(dataManager: upcomingListManager, titleString: "upcoming".localized, signedIn: signedIn)]
        super.init(viewControllers: topListVCs, title: "topListVCTitle".localized)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
