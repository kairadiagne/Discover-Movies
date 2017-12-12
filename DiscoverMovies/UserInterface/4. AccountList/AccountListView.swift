//
//  AccountListView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 02-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class AccountListView: BaseView {

    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()

        tableView.backgroundColor = .clear
        tableView.hideEmptyRows()
        tableView.refreshControl = refreshControl
    }
}
