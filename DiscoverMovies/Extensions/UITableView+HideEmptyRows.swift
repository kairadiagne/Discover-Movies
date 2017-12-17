//
//  UITableView+HideEmptyRows.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 02-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

extension UITableView {
    
    func hideEmptyRows() {
        tableFooterView = UIView(frame: .zero)
    }
}
