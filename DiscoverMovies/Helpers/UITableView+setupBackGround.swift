//
//  UITableView+setupBackground.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 21-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

extension UITableViewController {
    
    func setupBackground(withMessage message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.Body()
        label.textAlignment = .Center
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.text = message
        label.sizeToFit()
        tableView.backgroundView = label
        tableView.backgroundView?.hidden = true
    }
    
}