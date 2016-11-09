//
//  ReviewdataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class ReviewDataSource: NSObject, DataContaining, UITableViewDataSource {
    
    typealias ItemType = Review
    
    // MARK: Properties

    var items: [Review] = []
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !isEmpty ? items.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataCell.defaultIdentifier(), for: indexPath) as! NoDataCell
            let message = NSLocalizedString("noReviewMessage", comment: "")
            cell.messageLabel.text = message
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.defaultIdentifier(), for: indexPath) as! ReviewTableViewCell
            cell.configure(items[indexPath.row])
            return cell
        }
    }
    
}
