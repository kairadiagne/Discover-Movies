//
//  SignInViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

protocol SignInViewControllerDelegate: class {
    func signInViewControllerDidFinish(_ controller: SignInViewController)
}

final class SignInViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet var signInView: SignInView!
    
    weak var delegate: SignInViewControllerDelegate?
    
    private let authenticator: UserAuthenticating
    
    // MARK: - Initialize 
    
    init(authenticator: UserAuthenticating) {
        self.authenticator = authenticator
        super.init(nibName: nil, bundle: nil)
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
        signIn()
    }
    
    @IBAction func signInlaterButtonClick(_ sender: UIButton) {
        delegate?.signInViewControllerDidFinish(self)
    }

    private func signIn() {
        authenticator.authenticate(delegate: self)
    }
}

// MARK: - UserAuthenticatingContextProviding

extension SignInViewController: UserAuthenticatingDelegate {

    func present(authenticationController: UIViewController) {
        present(authenticationController, animated: true, completion: nil)
    }

    func didFinishAuthentication(with result: Result<Void, Error>) {
        dismiss(animated: true) {
            switch result {
            case .success:
                self.signInView.set(state: .idle)
                self.delegate?.signInViewControllerDidFinish(self)
            case .failure(let error):
                self.signInView.set(state: .idle)
                // ErrorHandler.shared.handle(error: error)
            }
        }
    }
}
