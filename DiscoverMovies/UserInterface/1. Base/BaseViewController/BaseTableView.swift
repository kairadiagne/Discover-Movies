//
//  BaseTableView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 06/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class BaseTableView: UITableView, BackgroundMessagePresentable {
    
    var messageLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Add empty UIView to the footer so that empty cells are not visible
        self.tableFooterView = UIView()
    }
    
    func scrollToTop() {
        if numberOfRowsInSection(0) > 0 {
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: false)
        }
    }

}

