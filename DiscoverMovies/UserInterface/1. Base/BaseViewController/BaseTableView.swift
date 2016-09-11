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
        if numberOfRows(inSection: 0) > 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }

}

