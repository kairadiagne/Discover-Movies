//
//  BaseViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SWRevealViewController

class BaseViewController: UIViewController, DataManagerFailureDelegate {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Determines if the signin view controller needs to be shown
        if TMDbSessionManager.shared.signInStatus == .unkown {
            showSignInViewController()
        }
    }
    
    // MARK: - DataManagerNotifications
    
    func dataManagerDidStartLoading(notification: Notification) {
    }
    
    func dataManagerDidUpdate(notification: Notification) {
    }
    
    // MARK: - DataManagerFailureDelegate
    
    func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
    }
    
    // MARK: - Menu
    
    func addMenuButton() {
        guard let revealViewController = self.revealViewController() else { return }
        view.addGestureRecognizer(revealViewController.panGestureRecognizer())
        
        let menuButton = UIBarButtonItem()
        menuButton.image = UIImage.menuIcon()
        menuButton.target = revealViewController
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationItem.leftBarButtonItem = menuButton
    }
    
    // MARK: - Sign in 
    
    func showSignInViewController() {
        let signInViewController = SignInViewController()
        present(signInViewController, animated: true, completion: nil)
    }

}
