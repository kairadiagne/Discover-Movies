//
//  MenuTableViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 02-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell, NibReusabelCell {
    
    // MARK: - Properties 
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.backgroundColor()
        titleLabel.font = UIFont.H3()
        titleLabel.textColor = UIColor.white
        iconImageView.tintColor = UIColor.white
    }
    
    // MARK: - Configure
    
    func configure(title: String, image: UIImage?, enable: Bool) {
        titleLabel.text = title
        iconImageView.image = image
        titleLabel.isEnabled = enable
        isUserInteractionEnabled = enable
    }
}
