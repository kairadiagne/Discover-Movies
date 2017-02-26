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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        revealViewController().tapGestureRecognizer()
        revealViewController().panGestureRecognizer()
        revealViewController().delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        navigationController?.delegate = self
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
        guard let revealViewController = revealViewController() else {
            return
        }
        
        let menuButton = UIBarButtonItem()
        menuButton.image = UIImage.menuIcon()
        menuButton.target = revealViewController
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationItem.leftBarButtonItem = menuButton
    }
    
    // MARK: - Navigation 
    
    func showDetailViewController(for movie: MovieRepresentable, signedIn: Bool) {
        let detailViewController = DetailViewController(movie: movie, signedIn: signedIn)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - Rotation 
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}

//MARK: - SWRevealViewControllerDelegate

extension BaseViewController: SWRevealViewControllerDelegate {
    
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        if position == FrontViewPosition.right {
            revealController.frontViewController.view.isUserInteractionEnabled = false
        }
        else {
            revealController.frontViewController.view.isUserInteractionEnabled = true
        }
    }

}

// MARK: - UINavigationControllerDelegate

extension BaseViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push && toVC is DetailViewController {
            return DetailAnimatedTransitioning()
        } else {
            return CrossDissolveAnimatedTransitioning()
        }
    }
    
}
