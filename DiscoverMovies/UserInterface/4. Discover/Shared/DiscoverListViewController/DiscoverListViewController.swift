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
        static let DiscoverCellRowHeight: CGFloat = 250
    }
    
    // MARK: Properties
    
    var tableViewDataProvider = DiscoverDataProvider()
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMenuButton()
        
        let nib = UINib(nibName: DiscoverListCell.nibName(), bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: DiscoverListCell.defaultIdentifier())
        tableView.rowHeight = Constants.DiscoverCellRowHeight
        tableView.dataSource = tableViewDataProvider
    }
    
    // MARK: Navigation
    
    func showDetailViewControllerForMovie(movie: Movie) { 
        let image = SDWebImageManager.sharedManager().getImageFromCache(movie)
        let detailViewController = DetailViewController(movie: movie, image: image)
        navigationController?.pushViewController(detailViewController, animated: false)
    }
    
}
