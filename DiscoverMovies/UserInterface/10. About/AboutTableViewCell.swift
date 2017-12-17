//
//  AcknowledgementCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 30-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class AcknowledgementCell: UITableViewCell, NibReusabelCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!
 
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont.Caption()
        licenseLabel.font = UIFont.Caption2()
        
        titleLabel.textColor = .white
        licenseLabel.textColor = .white
    }
    
    // MARK: - Configure
    
    func configure(with acknowledgement: Acknowledgement) {
        titleLabel.text = acknowledgement.title
        
        if let license = acknowledgement.license {
           licenseLabel.text = "license".localized + " " + license
        }
    }
    
}
