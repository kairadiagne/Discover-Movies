//
//  SignInView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class SignInView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tmdbLogo: UIImageView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var signInButton: CustomButton!
    @IBOutlet weak var publicModeButton: CustomButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.H1()
        descriptionLabel.font = UIFont.Body()
        instructionLabel.font = UIFont.Caption()
    }
    
}
