//
//  AboutTableViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 30-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class AboutTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!
    @IBOutlet weak var footerLabel: UILabel!
 
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    // MARK: - Configure
    
    func configure(with acknowledgement: Acknowledgement) {
        titleLabel.text = acknowledgement.title
        licenseLabel.text = acknowledgement.license
        footerLabel.text = acknowledgement.footer
    }
    
}
