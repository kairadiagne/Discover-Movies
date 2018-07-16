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

final class SignInViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet var signInView: SignInView!

    private let authenticationManager: AuthenticationManager

    private let userDataManager: UserDataManager
    
    // MARK: - Initialize 
    
    init(authenticationManager: AuthenticationManager, userDataManager: UserDataManager) {
        self.authenticationManager = authenticationManager
        self.userDataManager = userDataManager

        super.init(nibName: nil, bundle: nil)

//        self.userDataManager.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Rotation
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    // MARK: - Status Bar 
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions
    
    @IBAction func signInButtonClick(_ sender: UIButton) {
        signInView.set(state: .loading)
        authenticationManager.requestToken()
    }
    
    @IBAction func signInlaterButtonClick(_ sender: UIButton) {
//        sessionManager.activatePublicMode()
//        delegate?.signInViewControllerDidFinish()
    }
}

// MARK: - TMDbSignInDelegate

//extension SignInViewController: TMDbSignInDelegate {
//    
//    func signIn(service: TMDbSignInService, didReceiveAuthorizationURL url: URL) {
//        signInView.set(state: .idle)
//        
//        safariViewController = SFSafariViewController(url: url)
//        safariViewController.delegate = self
//        
//        present(safariViewController, animated: true, completion: nil)
//    }
//    
//    func signIn(service: TMDbSignInService, didFailWithError error: APIError) {
//        signInView.set(state: .idle)
//        ErrorHandler.shared.handle(error: error)
//    }
//    
//    func signInServiceDidSignIn(_ service: TMDbSignInService) {
//        signInView.set(state: .idle)
//        userService.getUserInfo()
//        delegate?.signInViewControllerDidFinish()
//    }
//}

// MARK: - SFSafariViewControllerDelegate

extension SignInViewController: SFSafariViewControllerDelegate {
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        if !didLoadSuccessfully {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        signInView.set(state: .loading)
//        signInService.requestSessionID()
    }
}

private var safariViewController: SFSafariViewController! {
    didSet {
        safariViewController?.preferredControlTintColor = .blue
    }
}
