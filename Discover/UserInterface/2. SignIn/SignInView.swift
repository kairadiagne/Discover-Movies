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
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInLaterButton: UIButton!
    @IBOutlet weak var signInDescription: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        signInDescription.textColor = UIColor.white
        titleLabel.textColor = UIColor.white
        orLabel.tintColor = UIColor.white
        signInButton.tintColor = UIColor.white
        signUpButton.tintColor = UIColor.white
        signInLaterButton.tintColor = UIColor.white
    
        titleLabel.font = UIFont.H1()
        orLabel.font = UIFont.Caption()
        signInDescription.font = UIFont.Body()
    
        let signInButtonText = NSLocalizedString("signInButtonText", comment: "")
        signInButton.setTitle(signInButtonText, for: .normal)
        
        let signInLaterButtonText = NSLocalizedString("signUpButtonText", comment: "")
        signInLaterButton.setTitle(signInLaterButtonText, for: .normal)
        
        let signUpButtonText = NSLocalizedString("signUpButtonText", comment: "")
        signUpButton.setTitle(signUpButtonText, for: .normal)
    }

}

