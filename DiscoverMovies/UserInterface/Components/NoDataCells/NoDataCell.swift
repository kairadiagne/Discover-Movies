//
//  NoDataCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class NoDataCell: UITableViewCell {
    
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
