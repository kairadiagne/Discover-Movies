//
//  MenuDataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

enum MenuCell: String {
    case ProfileCell
    case MenuItem
}

class MenuDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let menuItems = [Int]() // Array Of Type menu Item
    
    // MARK: - Initialzation 
    
    override init() {
        
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch MenuCell {
            
        }
        return UITableViewCell()
    }
    
    
    
    
    
    // MARK: - UITableViewDelegate
    
    
    
    
    
    
    
    
}


