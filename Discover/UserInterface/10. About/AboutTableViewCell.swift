//
//  AcknowledgementCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 30-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class AcknowledgementCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!
 
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont.Caption()
        licenseLabel.font = UIFont.Caption2()
        
        titleLabel.textColor = UIColor.white
        licenseLabel.textColor = UIColor.white
    }
    
    // MARK: - Configure
    
    func configure(with acknowledgement: Acknowledgement) {
        titleLabel.text = acknowledgement.title
        
        if let license = acknowledgement.license {
           licenseLabel.text = NSLocalizedString("license", comment: "") + " " + license
        }
    }
    
}
