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

protocol SignInViewControllerDelegate: class {
    func signInViewControllerDidFinish()
}

class SignInViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet var signInView: SignInView!
    
    weak var delegate: SignInViewControllerDelegate?
    
    fileprivate let sessionManager: TMDbSessionManager
    
    fileprivate let signInService: TMDbSignInService
    
    fileprivate let userService: TMDbUserService
    
    fileprivate var safariViewController: SFSafariViewController! {
        didSet {
            if safariViewController != nil {
                if #available(iOS 10.0, *) {
                    safariViewController.preferredControlTintColor = UIColor.blue
                } else {
                    safariViewController.view.tintColor = UIColor.defaultButtonColor()
                }
            }
        }
    }
    
    // MARK: - Initialize 
    
    init(sessionManager: TMDbSessionManager, signInService: TMDbSignInService = TMDbSignInService(), userService: TMDbUserService = TMDbUserService()) {
        self.sessionManager = sessionManager
        self.signInService = signInService
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        signInService.delegate = self
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions
    
    @IBAction func signInButtonClick(_ sender: UIButton) {
        signInView.set(state: .loading)
        signInService.requestToken()
    }
    
    @IBAction func signInlaterButtonClick(_ sender: UIButton) {
        sessionManager.activatePublicMode()
        delegate?.signInViewControllerDidFinish()
    }
    
}

// MARK: - TMDbSignInDelegate

extension SignInViewController: TMDbSignInDelegate {
    
    func signIn(service: TMDbSignInService, didReceiveAuthorizationURL url: URL) {
        signInView.set(state: .idle)
        
        safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        
        present(safariViewController, animated: true, completion: nil)
    }
    
    func signIn(service: TMDbSignInService, didFailWithError error: APIError) {
        signInView.set(state: .idle)
        ErrorHandler.shared.handle(error: error)
    }
    
    func signInServiceDidSignIn(_service service: TMDbSignInService) {
        signInView.set(state: .idle)
        userService.getUserInfo()
        delegate?.signInViewControllerDidFinish()
    }
    
}

// MARK: - SFSafariViewControllerDelegate

extension SignInViewController: SFSafariViewControllerDelegate {
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        if !didLoadSuccessfully {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        signInView.set(state: .loading)
        signInService.requestSessionID()
    }
}
