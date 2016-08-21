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
    
    // MARK: Properties
    
    @IBOutlet weak var discoverLabel: UILabel!
    @IBOutlet weak var watchListLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var signoutlabel: UILabel!
    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var watchlistCell: UITableViewCell!
    @IBOutlet weak var favoriteCell: UITableViewCell!
    
    // MARK: Awake From Nib
    
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
    
    // MARK: Configure
    
    func updateMenu(signedIn: Bool, user: User? = nil) {
        usernameLabel.text = user?.name ?? "Guest"
        signoutlabel.text = signedIn ? "Sign out" : "Sign in" 
        watchListLabel.enabled = signedIn
        watchlistCell.userInteractionEnabled = signedIn
        favoritesLabel.enabled = signedIn
        favoriteCell.userInteractionEnabled = signedIn
        
        if let path = user?.profileHash, url = TMDbImageRouter.ProfileSmall(path: path).url {
            profileImageView.imageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
        } else {
            profileImageView.imageView.image = nil
        }
    }
    
}
