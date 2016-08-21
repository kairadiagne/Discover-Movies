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

    private var safariViewController: SFSafariViewController!
    
    private let signInService = TMDbSignInService()
    
    private let userService = TMDbUserService()
    
    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        signInService.delegate = self
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: Actions
    
    @IBAction func signIn(sender: UIButton) {
        activateSignInFlow()
    }
    
    @IBAction func activatePublicMode(sender: UIButton) {
        sessionManager.activatePublicMode()
        dismissSignInViewController()
    }
    
    // MARK: SignIn
    
    func activateSignInFlow() {
        showProgressHUD()
        signInService.requestToken()
    }
    
    func requestSessionID() {
        showProgressHUD()
        signInService.requestSessionID()
    }
    
    func requestAuthorization(url: NSURL) {
        safariViewController = SFSafariViewController(URL: url)
        safariViewController.delegate = self
        presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    // MARK: Handle Errors
    
    func handleError(error: NSError) {
        // Rewrite 
    }
    
    // MARK: Navigation
    
    func dismissSignInViewController() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

}

// MARK: TMDbSignInDelegate

extension SignInViewController: TMDbSignInDelegate {
    
    func signIn(service: TMDbSignInService, didReceiveAuthorizationURL url: NSURL) {
        hideProgressHUD()
        requestAuthorization(url)    }
    
    func signIn(service: TMDbSignInService, didFailWithError error: NSError) {
        hideProgressHUD()
        self.handleError(error)
    }
    
    func signInServiceDidSignIn(service: TMDbSignInService) {
        hideProgressHUD()
        userService.getUserInfo()
        dismissSignInViewController()
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



    


    

    

    




