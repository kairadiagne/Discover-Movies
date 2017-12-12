//
//  SearchView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 03-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class SearchView: UIView {

    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .backgroundColor()
        tableView.backgroundColor = .clear
    }
}
