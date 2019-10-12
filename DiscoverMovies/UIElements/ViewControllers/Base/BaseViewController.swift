//
//  BaseViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class BaseViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        navigationController?.delegate = self
    }
    
    // MARK: - DataManagerNotifications
    
    @objc func dataManagerDidStartLoading(notification: Notification) {
    }
    
    @objc func dataManagerDidUpdate(notification: Notification) {
    }
    
    // MARK: - DataManagerFailureDelegate
    
    func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
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

// MARK: - UINavigationControllerDelegate

extension BaseViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push && toVC is DetailViewController {
            return DetailAnimatedTransitioning()
        } else {
            return CrossDissolveAnimatedTransitioning()
        }
    }
}
