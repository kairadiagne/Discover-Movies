//
//  PullToRefreshable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

// MARK: - Protocol PullToRefreshable

protocol PullToRefreshable {
    var dateFormatter: NSDateFormatter { get }
    var refreshControl: UIRefreshControl { get }
    func registerRefreshSelector(selector: Selector)
    func refresh(sender: UIRefreshControl)
    func stopRefreshing()
}

// MARK: - Default Implementation PullToRefreshable

extension PullToRefreshable where Self: UIViewController {
    
    var dateFormatter: NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .LongStyle
        return dateFormatter
    }
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        // TODO: - NSLocalizedString
        let now = NSDate()
        refreshControl.attributedTitle = NSMutableAttributedString(string: "Last Updated at " + dateFormatter.stringFromDate(now))
        return UIRefreshControl()
    }
    
    func registerRefreshSelector(selector: Selector) {
        refreshControl.addTarget(self, action: selector, forControlEvents: .ValueChanged)
    }
    
    func stopRefreshing() {
        if refreshControl.refreshing {
            refreshControl.endRefreshing()
            
            // Set title to last updated date (current date)
            let now = NSDate()
            let lastUpdated = NSMutableAttributedString(string: "Last Updated at " + dateFormatter.stringFromDate(now))
            let range = NSRange(location: 0, length: lastUpdated.length)
            lastUpdated.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: range)
            refreshControl.attributedTitle = lastUpdated
        }
    }
    
}


