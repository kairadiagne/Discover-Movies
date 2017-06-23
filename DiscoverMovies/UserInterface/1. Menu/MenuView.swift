//
//  MenuView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 02-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class MenuView: UIView {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.backgroundColor()
        profileView.backgroundColor = UIColor.clear
        
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = .center
        
        tableView.hideEmptyRows()
    }
    
    // MARK: - Configure
    
    func configure(withUser user: User? = nil) {
        nameLabel.text = user?.name ?? "nameLabelGuest".localized
        
        if let path = user?.profileHash, let url = TMDbImageRouter.profileLarge(path: path).url {
            profileImageView.imageView.sd_setImage(with: url, placeholderImage: UIImage.placeholderImage())
        } else {
            profileImageView.imageView.image = UIImage.placeholderImage()
        }
    }
    
}
