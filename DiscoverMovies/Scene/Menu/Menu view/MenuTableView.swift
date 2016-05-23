//
//  MenuTableView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

class MenuTableView: UITableView {
    
    private struct Constants {
        static let ProfileHeaderHeight: CGFloat = 200
        static let HeaderViewNibName = "MenuHeaderView"
    }
    
    private var headerView: MenuHeaderView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scrollEnabled = false
        contentInset = UIEdgeInsets(top: Constants.ProfileHeaderHeight, left: 0, bottom: 0, right: 0)
        
//        headerView = MenuHeaderView.loadFromNib()
//        headerView.frame = CGRect(x: 0, y: 0, width: self.bounds.width * 0.6, height: Constants.ProfileHeaderHeight)
//        addSubview(headerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        headerView.frame.size.width = self.bounds.width
    }
    
    // MARK: - Configure

    func configureProfileHeader(user: TMDbUser? = nil, url: NSURL? = nil) {
//        if let user = user, url = url  {
//            headerView.profileImageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
//            headerView.usernameLabel.text = user.name != nil ? user.name! : "Unknown"
//        } else {
//            headerView.profileImageView.image = nil
//            headerView.usernameLabel.text = "Sign in"
//        }
    }
    
}
