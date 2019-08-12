//
//  AboutView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 30-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

final class AboutView: BaseView {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.hideEmptyRows()
    }

}
