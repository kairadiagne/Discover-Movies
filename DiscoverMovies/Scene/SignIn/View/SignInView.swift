//
//  SignInView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class SignInView: BackgroundView {

    @IBOutlet weak var logoImage: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var publicModeButton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.H1()
        orLabel.font = UIFont.Body()
        signUpLabel.font = UIFont.Caption2()
        
        logoImage.tintColor = UIColor.whiteColor()
        logoImage.userInteractionEnabled = false
    
        signInButton.tintColor = UIColor.whiteColor()
        signInButton.layer.borderWidth = 1.0
        signInButton.layer.borderColor = UIColor.whiteColor().CGColor
        signInButton.layer.backgroundColor = UIColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 0.05).CGColor
        
        publicModeButton.tintColor = UIColor.whiteColor()
        publicModeButton.layer.borderWidth = 1.0
        publicModeButton.layer.borderColor = UIColor.whiteColor().CGColor
        publicModeButton.layer.backgroundColor = UIColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 0.05).CGColor
    }
    
    // MARK: - Animations 
    
   
    
    
}

