//
//  DiscoverListViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

class DiscoverListViewController: ListViewController, MenuButtonPresentable {
    
    // MARK: Constants
    
    private struct Constants {
        static let DiscoverCellNibName = "DiscoverListCell"
        static let DiscoverCellIdentifier = "DiscoverListIdentifier"
        static let DiscoverCellRowHeight: CGFloat = 250
    }
    
    // MARK: Properties
    
    var tableViewDataProvider = DiscoverDataProvider()
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMenuButton()
        
        tableViewDataProvider.cellIdentifier = Constants.DiscoverCellIdentifier
        tableView.dataSource = tableViewDataProvider
        
        let nib = UINib(nibName: Constants.DiscoverCellNibName, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: Constants.DiscoverCellIdentifier)
        tableView.rowHeight = Constants.DiscoverCellRowHeight
    }
    
    // MARK: Navigation
    
    func showDetailViewControllerForMovie(movie: TMDbMovie) { 
        let image = SDWebImageManager.sharedManager().getImageFromCache(movie)
        let detailViewController = DetailViewController(movie: movie, image: image)
        navigationController?.pushViewController(detailViewController, animated: false)
    }
    
}
