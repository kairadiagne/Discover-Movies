//
//  PullToRefreshable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

protocol PullToRefreshable: class {
    var dateFormatter: NSDateFormatter { get }
    func configureRefreshControl()
    func addTargetToRefreshControl()
    func refresh(sender: AnyObject)
    func stopRefreshing()
}

extension PullToRefreshable where Self: UITableViewController {
    
    var dateFormatter: NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .LongStyle
        return dateFormatter
    }
    
    func configureRefreshControl() {
        if refreshControl == nil {
            refreshControl = UIRefreshControl()
            refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
            addTargetToRefreshControl()
        }
    }
    
    func stopRefreshing() {
        if refreshControl != nil && refreshControl!.refreshing {
            refreshControl?.endRefreshing()
            let now = NSDate()
            let updateString = NSMutableAttributedString(string: "Last Updated at " + dateFormatter.stringFromDate(now))
            let range = NSRange(location: 0, length: updateString.length)
            updateString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: range)
            refreshControl?.attributedTitle = updateString
        }
    }
    
}

