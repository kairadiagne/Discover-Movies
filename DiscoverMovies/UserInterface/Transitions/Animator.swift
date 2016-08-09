//
//  Animator.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 30-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: Properties 
    
    private let animationDuration: NSTimeInterval
    
    private var selectedCellFrame: CGRect?
    
    private var originalTableViewY: CGFloat?
    
    // MARK: Initialization
    
    init(animationDuration: NSTimeInterval) {
        self.animationDuration = animationDuration
    }
    
    // MARK: Animation Transition
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // Push
        if let topListviewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? TopListViewController,
            detailViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? DetailViewController {
            // Perform transition animations 
            transitionFrom(topListviewController, toDetailViewController: detailViewController, withContext: transitionContext)
        }
        // Pop
    }
    
    // MARK: Animations 
    
    private func transitionFrom(topListVC: TopListViewController, toDetailViewController detailVC: DetailViewController, withContext context: UIViewControllerContextTransitioning) {
        
        if let indexPath = topListVC.tableView.indexPathForSelectedRow,
            selectedCell = topListVC.tableView.cellForRowAtIndexPath(indexPath) as? DiscoverListCell {
            
            // At this stage viewWillDissapear and viewWillAppear are already being called
            let toplistView = topListVC.view
            let detailView = detailVC.detailView
            
            // Setup 'toView' before animation
            detailView.frame = toplistView.frame
            
            // Add to view hierarchy
            context.containerView()?.addSubview(detailView)
            
            // Cell background -> hero image view transition 
            // (don't want to mess with actual views, 
            // so creating a new image view just for transition)
            let backdropImage = UIImageView()
            backdropImage.contentMode = .ScaleToFill
            backdropImage.frame = selectedCell.frame
            backdropImage.image = selectedCell.imageView?.image
            backdropImage.alpha = 0.0
            detailVC.detailView.addSubview(backdropImage)

            // Save the table view's original position and selected cell frame
            // (as a property) to move them back during pop transition animation
            selectedCellFrame = selectedCell.frame
            originalTableViewY = topListVC.tableView.frame.origin.y

            // Figure out by how much need to move content
            let headerHeight = detailVC.detailView.header.frame.height
            let deltaY = selectedCell.center.y - headerHeight / 2.0
            
            // prepare detail view for animation
            detailView.alpha = 0.0
            toplistView.alpha = 0.0
            
            detailVC.automaticallyAdjustsScrollViewInsets = true 
            
//            postListVC.hideElementsForPushTransition() // (more about that later)
            UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .CurveEaseInOut, animations: {
                // Adjust the table view frtame so it appears like whole content is movin with cell image
                topListVC.tableView.frame.origin.y -= deltaY
                
                // Move our transitioning imageView towards the header image position
                backdropImage.frame = CGRect(x: 0.0, y: 0.0, width: 375, height: 250)
                
                backdropImage.alpha = 1.0
                detailVC.detailView.alpha = 1.0

            }, completion: { completed in
                context.completeTransition(!context.transitionWasCancelled())
                
                detailView.animateOnScreen()
            })
            
            
        }
    }
    
//    // hide "your future pack" label
//    categoryVC.titleLabel.alpha = 0.0
//    
//    // adjust table view frame so it appears like whole content is moving with cell image
//    categoryVC.tableView.frame.origin.y -= deltaY
//    
//    // move our transitioning imageView towards hero image position (and grow its size at the same time)
//    imageView.frame = CGRect(x: 0.0, y: 0.0, width: imageView.frame.width, height: heroFinalHeight)
//    imageView.alpha = 1.0
//    
//    postListVC.view.alpha = 1.0
//    
//}) { finished in
//    
//    // now we are ready to show real heroView on top of our imageView
//    postListVC.view.sendSubviewToBack(imageView)
//    
//    postListVC.categoryDescriptionBottomSpacer.constant = originalCategoryDescriptionBottomSpacerConstant
//    postListVC.prepareToCompletePushTransition() // (more about that later)
//    
//    // prepare constraints for animation
//    let autoLayoutViews = [postListVC.backButton, postListVC.categoryDescription, postListVC.categoryTitle]
//    for view in autoLayoutViews { view.setNeedsUpdateConstraints() }
//    
//    UIView.animateWithDuration(0.3, animations: {
//        postListVC.heroView.alpha = 1.0
//        for view in autoLayoutViews { view.layoutIfNeeded() }
//        
//    }) { finishedInner in
//        
//        // clean up & revert all the temporary things
//        imageView.removeFromSuperview()
//        categoryVC.titleLabel.alpha = 1.0
//        categoryVC.tableView.deselectRowAtIndexPath(indexPath, animated: false)
//        
//        context.completeTransition(!context.transitionWasCancelled())
//    }
    
    // MARk: Helpers
    
    
}

// Responsibilities
// 1. Insertion of to viewcontrollers view into the container view
// 2. When the transition animation completes:
// - The to and from viewcontrollers views need to be in their designated positions
// - The context completeTransition method needs to be invoked

// Get the index path of the selected row of the TopListViewControllers tableView
// This is the row that initiated the transition and the data in this row will be viewed inside the detailViewController.
// And which image we









