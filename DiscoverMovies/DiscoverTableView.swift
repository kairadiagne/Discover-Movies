//
//  DiscoverListTableView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 07/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class DiscoverTableView: BaseTableView {
    
    private struct Constants {
        static let DiscoverCellNibName = "DiscoverListCell"
        static let DiscoverCellIdentifier = "DiscoverListIdentifier"
        static let DiscoverCellRowHeight: CGFloat = 250
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Register cell 
        let cell = UINib(nibName: Constants.DiscoverCellNibName, bundle: nil)
        registerNib(cell, forCellReuseIdentifier: Constants.DiscoverCellIdentifier)
        
        // Set height of rows
        rowHeight = Constants.DiscoverCellRowHeight
        
    }

}
