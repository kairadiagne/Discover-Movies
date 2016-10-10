//
//  NoDataCollectionViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class NoDataCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var messageLabel: UILabel!

    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageLabel.font = UIFont.Body()
        messageLabel.textColor = UIColor.white
    }
    
    // MARK: - Configure
    
    func configure(with message: String) {
        messageLabel.text = message
    }

}
