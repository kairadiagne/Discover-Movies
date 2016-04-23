//
//  SignInViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var signInButton: CustomButton!
    @IBOutlet weak var continueButton: CustomButton!
    @IBOutlet weak var signInButtonCenterX: NSLayoutConstraint!
    @IBOutlet weak var continueButtonCenterX: NSLayoutConstraint!
    
    weak var delegate: SignInViewDelegate?
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel?.font = UIFont.H1()
        descriptionLabel?.font = UIFont.Body()
        instructionLabel?.font = UIFont.Caption1()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Set up center constraints of buttons for animation
        signInButtonCenterX.constant -= view.bounds.size.width
        continueButtonCenterX.constant -= view.bounds.size.width
        view.layoutIfNeeded()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [.CurveEaseInOut], animations: {
            self.signInButtonCenterX.constant += self.view.bounds.size.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(1.0, delay: 0.6, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [.CurveEaseInOut], animations: {
            self.continueButtonCenterX.constant += self.view.bounds.size.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - Sign in Actions
    
    @IBAction func signin(sender: CustomButton) {
        delegate?.signInViewDidTapSignInButton()
    }
    
    @IBAction func continueWithoutSignIn(sender: CustomButton) {
        delegate?.signInViewDidTapContinueWithoutSignInButton()
    }
    
}

