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
import SWRevealViewController

class MenuTableView: UITableView {
    
    // MARK: - Properties
    
    @IBOutlet weak var discoverLabel: UILabel!
    @IBOutlet weak var watchListLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var signoutlabel: UILabel!
    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var watchlistCell: UITableViewCell!
    @IBOutlet weak var favoriteCell: UITableViewCell!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        discoverLabel.font = UIFont.H3()
        watchListLabel.font = UIFont.H3()
        favoritesLabel.font = UIFont.H3()
        signoutlabel.font = UIFont.H3()
    }
    
    // MARK: - Life Cycle 
    
    override func layoutSubviews() {
        super.layoutSubviews()
        usernameLabel.center.x = profileImageView.center.x
    }
    
    // MARK: - Configure
    
    func updateMenu(_ signedIn: Bool, user: User? = nil) {
        usernameLabel.text = user?.name ?? "Guest"
        signoutlabel.text = signedIn ? "Sign out" : "Sign in" 
        watchListLabel.isEnabled = signedIn
        watchlistCell.isUserInteractionEnabled = signedIn
        favoritesLabel.isEnabled = signedIn
        favoriteCell.isUserInteractionEnabled = signedIn
        
        if let path = user?.profileHash, let url = TMDbImageRouter.profileSmall(path: path).url {
            profileImageView.imageView.sd_setImage(with: url, placeholderImage: UIImage.placeholderImage())
        } else {
            profileImageView.imageView.image = nil
        }
    }
    
}
