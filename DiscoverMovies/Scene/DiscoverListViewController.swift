//
//  DiscoverListViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class DiscoverListViewController: ListViewController {
    
    private struct Constants {
        static let DiscoverCellNibName = "DiscoverListCell"
        static let DiscoverCellIdentifier = "DiscoverListIdentifier"
        static let DiscoverCellRowHeight: CGFloat = 250
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: Constants.DiscoverCellNibName, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: Constants.DiscoverCellIdentifier)
        tableView.rowHeight = Constants.DiscoverCellRowHeight
    }
    
    
}
