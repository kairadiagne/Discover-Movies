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
    
    @IBOutlet weak var discoverLabel: UILabel!
    @IBOutlet weak var watchListLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var signoutlabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var watchlistCell: UITableViewCell!
    @IBOutlet weak var favoriteCell: UITableViewCell!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        discoverLabel.font = UIFont.H3()
        watchListLabel.font = UIFont.H3()
        favoritesLabel.font = UIFont.H3()
        signoutlabel.font = UIFont.H3()
        
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.backgroundColor = UIColor.clearColor().CGColor
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        usernameLabel.center.x = profileImageView.center.x
    }
    
    // MARK: - Configure
    
    func updateMenu(signedIn: Bool, user: TMDbUser?) {
        usernameLabel.text = user?.name ?? "Guest"
        signoutlabel.text = signedIn ? "Sign in" : "Sign out"
        watchListLabel.enabled = signedIn
        watchlistCell.userInteractionEnabled = signedIn
        favoritesLabel.enabled = signedIn
        favoriteCell.userInteractionEnabled = signedIn
        
        if let path = user?.profilePath, url = TMDbImageRouter.ProfileSmall(path: path).url {
            profileImageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
        } else {
            profileImageView.image = nil
        }
    }
    
}
