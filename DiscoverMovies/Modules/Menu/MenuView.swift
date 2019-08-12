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
        
        backgroundColor = .backgroundColor()
        profileView.backgroundColor = .clear
        
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center

        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension

        tableView.backgroundColor = .clear
        tableView.hideEmptyRows()
    }
    
    // MARK: - Configure
    
    func configure(withUser user: User? = nil) {
        nameLabel.text = user?.name ?? "nameLabelGuest".localized
        
        if let path = user?.avatar?.hash, let url = TMDbImageRouter.profileLarge(path: path).url {
            profileImageView.imageView.sd_setImage(with: url, placeholderImage: UIImage.placeholderImage())
        } else {
            profileImageView.imageView.image = UIImage.placeholderImage()
        }
    }
}
