//
//  GenreView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class GenreView: BaseView {

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
