//
//  SignInView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class SignInView: BaseView {
    
    // MARK: - Properties
    
    @IBOutlet weak var publicModeButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInDescription: UILabel!
    
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        signInDescription.textColor = UIColor.white
        signInButton.tintColor = UIColor.white
        signUpButton.tintColor = UIColor.white
        publicModeButton.tintColor = UIColor.white
        
    
        // signInButton.tintColor = UIColor.white
        // signInButton.layer.borderWidth = 1.0
        // signInButton.layer.borderColor = UIColor.white.cgColor
        // signInButton.layer.backgroundColor = UIColor(white: 1.0, alpha: 0.05).cgColor
        
        // publicModeButton.tintColor = UIColor.white
        // publicModeButton.layer.borderWidth = 1.0
        // publicModeButton.layer.borderColor = UIColor.white.cgColor
        // publicModeButton.layer.backgroundColor = UIColor(white: 1.0, alpha: 0.05).cgColor
        
        // signInButton.titleLabel?.text = NSLocalizedString("signInButtonText", comment: "")
        // publicModeButton.titleLabel?.text = NSLocalizedString("continueWithSignInButtonText", comment: "")
    }

}

