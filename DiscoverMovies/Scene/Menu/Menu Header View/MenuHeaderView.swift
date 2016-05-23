//MBBarProgressView
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
    
    class func loadFromNib() -> MenuHeaderView {
        return NSBundle.mainBundle().loadNibNamed("MenuHeaderView", owner: self, options: nil).first as! MenuHeaderView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    
        usernameLabel.textColor = UIColor.flatBlueColor()
        
        backgroundColor = UIColor.clearColor()
    }
        
}


