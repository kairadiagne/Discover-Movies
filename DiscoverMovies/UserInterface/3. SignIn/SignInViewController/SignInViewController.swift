//
//  SignInViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SafariServices

class SignInViewController: BaseViewController {
    
    // MARK: Properties

    private let userManager = TMDbUserManager()
    
    private let signInManager = TMDbSignInManager()
    
    private var safariViewController: SFSafariViewController!
    
    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        signInManager.delegate = self
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: Actions
    
    @IBAction func signIn(sender: UIButton) {
        activateSignInFlow()
    }
    
    @IBAction func activatePublicMode(sender: UIButton) {
        signInManager.activatePublicMode()
        dismissSignInViewController()
    }
    
    // MARK: SignIn
    
    func activateSignInFlow() {
        showProgressHUD()
        signInManager.requestToken()
    }
    
    func requestSessionID() {
        showProgressHUD()
        signInManager.requestSessionID()
    }
    
    func requestAuthorization(url: NSURL) {
        safariViewController = SFSafariViewController(URL: url)
        safariViewController.delegate = self
        presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    // MARK: Handle Errors
    
    func handleError(error: NSError) {
//        detectInternetConnectionError(error)
    }
    
    // MARK: Navigation
    
    func dismissSignInViewController() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

}

// MARK: TMDbSignInDelegate

extension SignInViewController: TMDbSignInDelegate {
    
    func signInDelegateShouldRequestAuthorization(url: NSURL) {
        hideProgressHUD()
        requestAuthorization(url)
    }
    
    func signInDelegateSigninDidComplete() {
        hideProgressHUD()
        userManager.loadUserInfo()
        dismissSignInViewController()
    }
    
    func signInDelegateSigninDidFail(error: NSError) {
        hideProgressHUD()
        self.handleError(error)
    }
    
}

// MARK: SFSafariViewControllerDelegate

extension SignInViewController: SFSafariViewControllerDelegate {
    
    func safariViewController(controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        if !didLoadSuccessfully {
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        requestSessionID()
    }
}



    


    

    

    



