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

    @IBOutlet weak var logoImage: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var publicModeButton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont.H1()
        orLabel.font = UIFont.Body()
        
        orLabel.textColor = UIColor.white
        titleLabel.textColor = UIColor.white
    
        logoImage.tintColor = UIColor.white
        logoImage.isUserInteractionEnabled = false
    
        signInButton.tintColor = UIColor.white
        signInButton.layer.borderWidth = 1.0
        signInButton.layer.borderColor = UIColor.white.cgColor
        signInButton.layer.backgroundColor = UIColor(white: 1.0, alpha: 0.05).cgColor
        
        publicModeButton.tintColor = UIColor.white
        publicModeButton.layer.borderWidth = 1.0
        publicModeButton.layer.borderColor = UIColor.white.cgColor
        publicModeButton.layer.backgroundColor = UIColor(white: 1.0, alpha: 0.05).cgColor
        
        signInButton.titleLabel?.text = NSLocalizedString("signInButtonText", comment: "")
        publicModeButton.titleLabel?.text = NSLocalizedString("continueWithSignInButtonText", comment: "")
    }

}

