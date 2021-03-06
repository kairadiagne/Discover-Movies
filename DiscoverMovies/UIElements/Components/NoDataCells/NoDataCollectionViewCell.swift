//
//  NoDataCollectionViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

final class NoDataCollectionViewCell: UICollectionViewCell, NibReusable, NoDataMessageConfigurable {
    
    // MARK: - Properties
    
    @IBOutlet weak var messageLabel: UILabel!

    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageLabel.font = UIFont.Body()
        messageLabel.textColor = .white
    }
}
