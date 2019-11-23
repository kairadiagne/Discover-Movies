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

    // MARK: - Navigation 
    
    func showDetailViewController(for movie: MovieRepresentable, signedIn: Bool) {
        let detailViewController = MovieDetailViewController(movie: movie, signedIn: signedIn)
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
        
        if operation == .push && toVC is MovieDetailViewController {
            return DetailAnimatedTransitioning()
        } else {
            return CrossDissolveAnimatedTransitioning()
        }
    }
}
