//
//  ReviewView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class ReviewView: BaseView {

    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.hideEmptyRows()
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
}
