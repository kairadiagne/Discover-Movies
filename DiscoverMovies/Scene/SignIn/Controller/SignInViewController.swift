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
    
    private struct Constants {
        static let RedirectURI = "discover://"
    }
    
    private let signInManager = TMDbSignInManager()
    private let userManager = TMDbUserManager()
    private var authorizationViewController: SFSafariViewController!
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        signInManager.delegate = self
    }
    
    // MARK: - Actions
    
    @IBAction func signIn(sender: UIButton) {
        activateSignInFlow()
    }
    
    @IBAction func activatePublicMode(sender: UIButton) {
        signInManager.activatePublicMode()
        dismissSignInViewController()
    }
    
    // MARK: - SignIn 
    
    func activateSignInFlow() {
        showProgressHUD()
        signInManager.requestToken(Constants.RedirectURI)
    }
    
    func authorizeOnTMDb(url: NSURL) {
        authorizationViewController = SFSafariViewController(URL: url)
        authorizationViewController.delegate = self
        presentViewController(authorizationViewController, animated: true, completion: nil)

    }
    
    func requestSessionID() {
        showProgressHUD()
        signInManager.requestSessionID()
    }
    
    // MARK: - Errror Handling
    
    func handleError(error: NSError) {
        detectInternetConnectionError(error)
    }
    
    // MARK: - Navigation
    
    func dismissSignInViewController() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

}

// MARK: - TMDbSignInmanager

extension SignInViewController: TMDbSignInDelegate {
    
    func signInDelegateShouldRequestAuthorization(url: NSURL) {
        hideProgressHUD()
        authorizeOnTMDb(url)
    }
    
    func signInDelegateSigninDidComplete() {
        hideProgressHUD()
        userManager.reloadIfNeeded(true)
        dismissSignInViewController()
    }
    
    func signInDelegateSigninDidFail(error: NSError) {
        hideProgressHUD()
        self.handleError(error)
    }
    
}

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



    


    

    

    




