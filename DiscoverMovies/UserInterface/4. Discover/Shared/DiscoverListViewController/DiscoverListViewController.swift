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

//class DiscoverListViewController: ListViewController, MenuButtonPresentable {
//    
//    // MARK: Constants
//    
//    fileprivate struct Constants {
//        static let DiscoverCellRowHeight: CGFloat = 250
//    }
//    
//    // MARK: Properties
//    
//    var tableViewDataProvider = DiscoverDataProvider()
//    
//    // MARK: View Controller Life Cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addMenuButton()
//        
//        let nib = UINib(nibName: DiscoverListCell.nibName(), bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: DiscoverListCell.defaultIdentifier())
//        tableView.rowHeight = Constants.DiscoverCellRowHeight
//        tableView.dataSource = tableViewDataProvider
//    }
//    
//    // MARK: Navigation
//    
//    func showDetailViewControllerForMovie(_ movie: Movie) { 
//        let image = SDWebImageManager.shared().getImageFromCache(movie)
//        let detailViewController = DetailViewController(movie: movie, image: image)
//        navigationController?.pushViewController(detailViewController, animated: false)
//    }
//    
//}
