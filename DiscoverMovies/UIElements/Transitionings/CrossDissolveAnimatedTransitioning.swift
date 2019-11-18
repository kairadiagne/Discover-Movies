//
//  CrossDissolveAnimatedTransitioning.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 31-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

final class CrossDissolveAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) {
            
            var fromView: UIView
            var toView: UIView
            
            if let fromViewController = transitionContext.view(forKey: .from), let toViewController = transitionContext.view(forKey: .to) {
                fromView = fromViewController
                toView = toViewController
            } else {
                fromView = fromVC.view
                toView = toVC.view
            }
            
            let containerView = transitionContext.containerView
            
            fromView.frame = transitionContext.initialFrame(for: fromVC)
            toView.frame = transitionContext.finalFrame(for: toVC)
            
            containerView.addSubview(toView)

            toView.alpha = 0
            fromView.alpha = 1
            
            let transitionDuration = self.transitionDuration(using: transitionContext)
            
            // Animate
            UIView.animate(withDuration: transitionDuration, delay: 0, options: [], animations: { 
                toView.alpha = 1
                fromView.alpha = 0
            }, completion: { _ in
                let transitionWasCancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!transitionWasCancelled)
                fromView.alpha = 1
            })
        }
    }
    
}
