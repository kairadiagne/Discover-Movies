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
        nameLabel.textAlignment = .center
    }
    
    // MARK: - Configure
    
    func configure(withUser user: User?) {
        nameLabel.text = user?.name ?? NSLocalizedString("nameLabelGuest", comment: "")
        
        if let path = user?.profileHash, let url = TMDbImageRouter.profileOriginal(path: path).url {
            profileImageView.imageView.sd_setImage(with: url, placeholderImage: UIImage.placeholderImage())
        } else {
            profileImageView.imageView.image = UIImage.placeholderImage()
        }
    }
    
}
