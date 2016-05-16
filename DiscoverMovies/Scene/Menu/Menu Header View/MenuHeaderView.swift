//
//  MenuHeaderView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import ChameleonFramework
import SDWebImage

class MenuHeaderView: UIView {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
     // MARK: - Awake From Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Profile image view
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        
        usernameLabel.textColor = UIColor.flatBlueColor()
    }
    
    // MARK: - Configure
    
    func configure(user: TMDbUser?, url: NSURL?) {
//        setImage(url)
//        self.usernameLabel.text = user?.name != nil ? "\(user!.name!)" : "Unknown"
    }
    
    private func setImage(url: NSURL?) {
        if let url = url {
            profileImageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderProfileImage())
        } else {
//            profileImageView.image = nil
        }
    }
    
}


