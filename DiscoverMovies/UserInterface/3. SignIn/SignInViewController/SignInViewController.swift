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

class SignInViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet var signInView: SignInView!
    
    fileprivate var safariViewController: SFSafariViewController!
    
    fileprivate let signInService = TMDbSignInService()
    
    fileprivate let userService = TMDbUserService()
    
    // MARK: - Life cycle

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
        signInView.set(state: .loading)
        signInService.requestToken()
    }
    
    func requestSessionID() {
        signInView.set(state: .loading)
        signInService.requestSessionID()
    }
    
    func requestAuthorization(_ url: URL) {
        safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true, completion: nil)
    }
    
    // MARK: Navigation
    
    func dismissSignInViewController() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}

// MARK: TMDbSignInDelegate

extension SignInViewController: TMDbSignInDelegate {
    
    func signIn(service: TMDbSignInService, didReceiveAuthorizationURL url: URL) {
        signInView.set(state: .idle)
        requestAuthorization(url)    }
    
    func signIn(service: TMDbSignInService, didFailWithError error: APIError) {
        signInView.set(state: .idle)
        ErrorHandler.shared.handle(error: error)
    }
    
    func signInServiceDidSignIn(_service service: TMDbSignInService) {
        signInView.set(state: .idle)
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
