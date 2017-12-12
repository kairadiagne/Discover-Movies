//
//  TopListViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

class TopListViewController: SegmentedViewController {
    
    // MARK; - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMenuButton()
    }
    
    // MARK:  - Initialize
    
    init(popularListManager: TMDbTopListDataManager,
         nowPlayingListManager: TMDbTopListDataManager,
         topRatedListManager: TMDbTopListDataManager,
         upcomingListManager: TMDbTopListDataManager,
         signedIn: Bool)
    {
        
        let topListVCs = [GenericTableViewController(dataManager: popularListManager, titleString: "popular".localized, signedIn: signedIn),
                          GenericTableViewController(dataManager: nowPlayingListManager, titleString: "nowPlaying".localized, signedIn: signedIn),
                          GenericTableViewController(dataManager: topRatedListManager, titleString: "topRated".localized, signedIn: signedIn),
                          GenericTableViewController(dataManager: upcomingListManager, titleString: "upcoming".localized, signedIn: signedIn)]
        super.init(viewControllers: topListVCs, title: "topListVCTitle".localized)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
