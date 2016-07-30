//
//  NavControllerDelegate.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 30-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

/// Delegate for the navigation controller (Here we implement methods related to transition animations 

class NavDelegate: NSObject, UINavigationControllerDelegate {
    
    private let animator = Animator(animationDuration: 4)
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}

