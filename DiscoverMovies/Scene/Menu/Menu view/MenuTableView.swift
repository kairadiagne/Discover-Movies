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
    
    @IBOutlet weak var discoverLabel: UILabel!
    @IBOutlet weak var watchListLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var signoutlabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        discoverLabel.font = UIFont.h3()
        watchListLabel.font = UIFont.h3()
        favoritesLabel.font = UIFont.h3()
        signoutlabel.font = UIFont.h3()
        
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.backgroundColor = UIColor.clearColor()
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.layer.masksToBounds = false
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
        
        backgroundColor = UIColor.

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
