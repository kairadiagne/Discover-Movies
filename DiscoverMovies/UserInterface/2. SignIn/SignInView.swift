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
    
    @IBOutlet weak var signInDescription: UILabel!
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInLaterButton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = UIColor.white
        signInDescription.textColor = UIColor.white
        signupLabel.textColor = UIColor.white
        orLabel.textColor = UIColor.white
    
        titleLabel.font = UIFont.H1()
        signInDescription.font = UIFont.H2()
        signupLabel.font = UIFont.Caption2()
        orLabel.font = UIFont.H2()
    
        signInButton.tintColor = UIColor.white
        signInLaterButton.tintColor = UIColor.white
        
        signInButton.titleLabel?.font = UIFont.H3()
        signInLaterButton.titleLabel?.font = UIFont.H3()
        
        titleLabel.text = "signInTitle".localized
        
        signInDescription.text = "signInDescription".localized
        signupLabel.text = "signUpInstruction".localized
    
        signInButton.setTitle("signInButtonText".localized, for: .normal)
        signInLaterButton.setTitle( "signInLaterButtonText".localized, for: .normal)
    }
}

