//
//  TableviewBackgroundMessagePresentable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

protocol BackgroundMessagePresentable {
    func configureViewWithBackgroundMessage(message: String)
}

extension BackgroundMessagePresentable where Self: UITableViewController {
    
    func configureViewWithBackgroundMessage(message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height:view.bounds.size.height))
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

