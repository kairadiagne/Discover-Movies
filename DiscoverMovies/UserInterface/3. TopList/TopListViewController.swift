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
        
        let topListVCs = [GenericViewController(dataManager: popularListManager, titleString: "Popular", signedIn: signedIn),
                          GenericViewController(dataManager: nowPlayingListManager, titleString: "Now Playing", signedIn: signedIn),
                          GenericViewController(dataManager: topRatedListManager, titleString: "Top Rated", signedIn: signedIn),
                          GenericViewController(dataManager: upcomingListManager, titleString: "Upcoming", signedIn: signedIn)]
        super.init(viewControllers: topListVCs, title: "topListVCTitle".localized)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
