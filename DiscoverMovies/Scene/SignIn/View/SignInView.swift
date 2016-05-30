//
//  SignInView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class SignInView: BackgroundView {

 
    @IBOutlet weak var tmdbLogo: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var publicModeButton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.H1()
        orLabel.font = UIFont.Body()
        titleLabel.font = UIFont.Body()
        signUpLabel.font = UIFont.Body()
        
        signInButton.tintColor = UIColor.whiteColor()
        signInButton.layer.borderWidth = 0.5
        signInButton.layer.borderColor = UIColor.whiteColor().CGColor
        signInButton.layer.backgroundColor = UIColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 0.05).CGColor
        signInButton.layer.cornerRadius = 5
        publicModeButton.tintColor = UIColor.whiteColor()
    }
    
    // Gradient background view in standard color 
    // Rechthoekig buttons met border color white
    // Animate the button press
    // Signinbutton
        // or 
    // continue without signin button 
    
// Explain that it uses data from the moviedb.org
    // Elements should animate on screen with alpha 
    
}

