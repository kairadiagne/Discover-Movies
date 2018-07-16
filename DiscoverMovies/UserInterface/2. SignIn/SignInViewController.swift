//
//  SignInViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        authenticationManager.delegate = self
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
        authenticationManager.authenticate()
    }
    
    @IBAction func signInlaterButtonClick(_ sender: UIButton) {
    }
}

// MARK: - AuthenticationManagerDelegate

extension SignInViewController: AuthenticationManagerDelegate {

    func authenticationManagerDidFinish(_ manager: AuthenticationManager) {
        signInView.set(state: .idle)
    }

    func authenticationManagerDidCancel(_ manager: AuthenticationManager) {
        signInView.set(state: .idle)
    }

    func authenticationManager(_ manager: AuthenticationManager, didFailWithError: Error) {
        signInView.set(state: .idle)
        // ErrorHandler.shared.handle(error: error)
    }
}
