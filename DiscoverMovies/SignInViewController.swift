//
//  SignInViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import BRYXBanner

class SignInViewController: BaseViewController {
    
    private struct Constants {
        static let RedirectURI = "discover://"
    }
    
    private let signInManager = TMDbSignInManager()
    private let userManager = TMDbUserManager()
    
    private let webView = UIWebView()
    
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
        // Progress HUD Start loading
        signInManager.requestToken(Constants.RedirectURI)
    }
    
    func authorizeOnTMDb(url: NSURL) {
        // Configure webview
        webView.frame = view.bounds
        webView.delegate = self
        webView.scalesPageToFit = true
        webView.hidden = false
        view.addSubview(webView)
        
        // Load authorization URL
        let authorizationRequest = NSURLRequest(URL: url)
        webView.loadRequest(authorizationRequest)
    }
    
    func requestSessionID() {
        // Start loading
        signInManager.requestSessionID()
        webView.hidden = true
    }
    
    // MARK: - Errror Handling
    
    func handleError(error: NSError) {
        detectInternetConnectionError(error)
        // Other error is alert (An error ocurred during the sign in process please try again).
    }
    
    // MARK: - Navigation
    
    func dismissSignInViewController() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

}

// MARK: - TMDbSignInmanager

extension SignInViewController: TMDbSignInDelegate {
    
    func signInDelegateShouldRequestAuthorization(url: NSURL) {
        authorizeOnTMDb(url)
    }
    
    func signInDelegateSigninDidComplete() {
        userManager.reloadIfNeeded(true)
        dismissSignInViewController()
    }
    
    func signInDelegateSigninDidFail(error: NSError) {
        webView.hidden = true
        webView.stopLoading()
        self.handleError(error)
    }
    
}

extension SignInViewController: UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // Check if the url that is being loaded by the webview is our redirect URI
        if let url = request.URL {
            if url == Constants.RedirectURI {
                requestSessionID()
            }
        }
        return true
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        guard let error = error else { return }
        self.handleError(error)
    }
}

