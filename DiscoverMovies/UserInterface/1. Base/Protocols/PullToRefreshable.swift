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
    var dateFormatter: DateFormatter { get }
    var refreshControl: UIRefreshControl { get }
    func registerRefreshSelector(_ selector: Selector)
    func refresh(_ sender: UIRefreshControl)
    func stopRefreshing()
}

// MARK: - Default Implementation PullToRefreshable

extension PullToRefreshable where Self: UIViewController {
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .long
        return dateFormatter
    }
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        // TODO: - NSLocalizedString
        let now = Date()
        refreshControl.attributedTitle = NSMutableAttributedString(string: "Last Updated at " + dateFormatter.string(from: now))
        return UIRefreshControl()
    }
    
    func registerRefreshSelector(_ selector: Selector) {
        refreshControl.addTarget(self, action: selector, for: .valueChanged)
    }
    
    func stopRefreshing() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
            
            // Set title to last updated date (current date)
            let now = Date()
            let lastUpdated = NSMutableAttributedString(string: "Last Updated at " + dateFormatter.string(from: now))
            let range = NSRange(location: 0, length: lastUpdated.length)
            lastUpdated.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: range)
            refreshControl.attributedTitle = lastUpdated
        }
    }
    
}


