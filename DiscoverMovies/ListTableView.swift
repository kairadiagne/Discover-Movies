//
//  ListTableView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 07/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class ListTableView: BaseTableView {
    
    // TODO: - Need a way to make this view more generic So it can be used for every table in the app
    // Or we need to remove the xib and let every table view have its own xib with baseTableView Subclass 
    // This sounds like the best sollution. 
    
    // TODO - Find out why I keep getting Autolayout constraint 
    
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
