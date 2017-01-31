
//
//  DetailTransitioning.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class DetailAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let _ = transitionContext.viewController(forKey: .from),
            let detailVC = transitionContext.viewController(forKey: .to) as? DetailViewController {
            
            let containerView = transitionContext.containerView
            
            let finalFrame = transitionContext.finalFrame(for: detailVC)
            detailVC.detailView.frame = finalFrame
            
            // Add detailVC immediatly on top of the view of the previous DetailViewController
            containerView.addSubview(detailVC.view)
            
            // Let content of detailVC scrollView slide on screen
            detailVC.detailView.animationConstraint.priority += 2
            detailVC.detailView.layoutIfNeeded()
   
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear], animations: {
                detailVC.detailView.animationConstraint.priority -= 2
                detailVC.detailView.layoutIfNeeded()
            }, completion: nil)
            
            // Fade in detailVC headerImage
            UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveLinear], animations: {
                detailVC.detailView.header.alpha = 1.0
            }, completion: nil)
            
            // Fade in detaiLVC playbutton
            UIView.animate(withDuration: 0.2, delay: 0.6, options: [.curveLinear], animations: {
                detailVC.detailView.playButton.alpha = 1.0
            }, completion: { completed in
                // Finish transition
                let wasCancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!wasCancelled)
            })
        }
    }
    
}


