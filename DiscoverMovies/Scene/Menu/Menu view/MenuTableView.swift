//
//  MenuTableView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class MenuTableView: UITableView {
    
    private struct Constants {
        static let ProfileHeaderHeight: CGFloat = 200
    }
    
    private var headerView = MenuHeaderView()
    
    // MARK: - Awake from Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scrollEnabled = false
        
        // Add profile header view
        contentInset = UIEdgeInsets(top: Constants.ProfileHeaderHeight, left: 0, bottom: 0, right: 0)
        headerView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: Constants.ProfileHeaderHeight)
        addSubview(headerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerView.frame.size.width = self.bounds.width
    }
    
    // MARK: - Configure
    
    func configureForUser(user: TMDbUser?, url: NSURL?) {
        headerView.configure(user, url: url)
    }
    
}
