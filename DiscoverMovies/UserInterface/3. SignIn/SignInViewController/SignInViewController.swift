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

    fileprivate var safariViewController: SFSafariViewController!
    
    fileprivate let signInService = TMDbSignInService()
    
    fileprivate let userService = TMDbUserService()
    
    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        signInService.delegate = self
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Actions
    
    @IBAction func signIn(_ sender: UIButton) {
        activateSignInFlow()
    }
    
    @IBAction func activatePublicMode(_ sender: UIButton) {
        TMDbSessionManager.shared.activatePublicMode()
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
    
    func requestAuthorization(_ url: URL) {
        safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true, completion: nil)
    }
    
    // MARK: Navigation
    
    func dismissSignInViewController() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}

// MARK: TMDbSignInDelegate

extension SignInViewController: TMDbSignInDelegate {
    
    func signIn(_ service: TMDbSignInService, didReceiveAuthorizationURL url: URL) {
        hideProgressHUD()
        requestAuthorization(url)    }
    
    func signIn(_ service: TMDbSignInService, didFailWithError error: APIError) {
        hideProgressHUD()
        self.handleError(error)
    }
    
    func signInServiceDidSignIn(_ service: TMDbSignInService) {
        hideProgressHUD()
        userService.getUserInfo()
        dismissSignInViewController()
    }
    
}

// MARK: SFSafariViewControllerDelegate

extension SignInViewController: SFSafariViewControllerDelegate {
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        if !didLoadSuccessfully {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        requestSessionID()
    }
}



    


    

    

    




