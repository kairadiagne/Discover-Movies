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
        
        // Responsibilities
        // 1. Insertion of to viewcontrollers view into the container view
        // 2. When the transition animation completes:
            // - The to and from viewcontrollers views need to be in their designated positions
            // - The context completeTransition method needs to be invoked
        
        // Get the index path of the selected row of the TopListViewControllers tableView
        // This is the row that initiated the transition and the data in this row will be viewed inside the detailViewController.
        // And which image we
        if let indexPath = topListVC.tableView.indexPathForSelectedRow,
            selectedCell = topListVC.tableView.cellForRowAtIndexPath(indexPath) as? DiscoverListCell {
            
            // The view that acts as the superview for the views involved in the transitioning (it contains both views in the transitioning)
//            context.containerView()?.addSubview(detailVC.view)
            
            // Create an image view that gets animated from the cell to the header in the detailViewController
            // Initialyy this view is hidden and gets slowly animated into the new view controller
            let imageView = UIImageView(frame: selectedCell.frame)
            imageView.image = selectedCell.movieImageView.image
            imageView.alpha = 0.0
            imageView.clipsToBounds = true // Is this neccesary
            
            // Keep a reference to the original positon of the tableView and the selected cell's frame
            // This animation is neccesarry to perform the pop animation 
            selectedCellFrame = selectedCell.frame
            originalTableViewY = topListVC.tableView.frame.origin.y
            
            // Figure out how much the content needs to move (From the position in the table view to the header in the detail view controller)
            let finalheight = detailVC.detailView.header.frame.height // This might not work because I calculate the height with a constraint
            let deltaY = selectedCell.center.y - finalheight / 2.0
            
            // Here view appears with slight delay (not in sync)
            // So need to hide it explicitly from container view
//            topListVC.view.alpha = 0.0
//            topListVC.tableView.alpha = 0.0
            
            // Hide all visible cells in the table view 
//            topListVC.tableView.visibleCells as! [UITableViewCell].map { $0.alpha = 0.0 }
            
            // Start of animation
            UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: .CurveEaseInOut, animations: {
                imageView.alpha = 1.0
                topListVC.tableView.backgroundColor = UIColor.redColor()
                topListVC.tableView.alpha = 0.0
//                topListVC.tableView.remove
                
                }, completion: { (true) in
                    
                    
                    
            })
            
            context.completeTransition(!context.transitionWasCancelled())
            
        }
    }
    
    // MARk: Helpers 
    
    
}






        
//        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: .CurveEaseInOut, animations: {
//            
//            // hide "your future pack" label
//            categoryVC.titleLabel.alpha = 0.0
//            
//            // adjust table view frame so it appears like whole content is moving with cell image
//            categoryVC.tableView.frame.origin.y -= deltaY
//            
//            // move our transitioning imageView towards hero image position (and grow its size at the same time)
//            imageView.frame = CGRect(x: 0.0, y: 0.0, width: imageView.frame.width, height: heroFinalHeight)
//            imageView.alpha = 1.0
//            
//            postListVC.view.alpha = 1.0
//            
//        }) { finished in
//            
//            // now we are ready to show real heroView on top of our imageView
//            postListVC.view.sendSubviewToBack(imageView)
//            
//            postListVC.categoryDescriptionBottomSpacer.constant = originalCategoryDescriptionBottomSpacerConstant
//            postListVC.prepareToCompletePushTransition() // (more about that later)
//            
//            // prepare constraints for animation
//            let autoLayoutViews = [postListVC.backButton, postListVC.categoryDescription, postListVC.categoryTitle]
//            for view in autoLayoutViews { view.setNeedsUpdateConstraints() }
//            
//            UIView.animateWithDuration(0.3, animations: {
//                postListVC.heroView.alpha = 1.0
//                for view in autoLayoutViews { view.layoutIfNeeded() }
//                
//            }) { finishedInner in
//                
//                // clean up & revert all the temporary things
//                imageView.removeFromSuperview()
//                categoryVC.titleLabel.alpha = 1.0
//                categoryVC.tableView.deselectRowAtIndexPath(indexPath, animated: false)
//                
//                context.completeTransition(!context.transitionWasCancelled())
//            }
//        }
//    }
//}
//
//
//private func createTransitionImageViewWithFrame(frame: CGRect) -> UIImageView {
//    let imageView = UIImageView(frame: frame)
//    imageView.contentMode = .ScaleAspectFill
//    imageView.setupDefaultTopInnerShadow()
//    imageView.clipsToBounds = true
//    return imageView
//}
//
//private extension PostListVC {
//   
//    
//    func prepareToCompletePushTransition() {
//        backButtonHorizontalSpacer.constant = 0.0
//        disableTransparencyAnimatedForViews(visibleCellViews)
//    }
//    
//    
//}
//
//func disableTransparencyAnimatedForViews(views: [UIView]) {
//    if let view = views.first {
//        UIView.animateWithDuration(0.2, animations: { view.alpha = 1.0 }) { _ in
//            disableTransparencyAnimatedForViews(Array(views[1..<views.count]))
//        }
//    }
//}
//
//private func moveFromPosts(postListVC: PostListVC, toCategories categoryVC: CategoryVC, withContext context: UIViewControllerContextTransitioning) {
//    
//    context.containerView().addSubview(categoryVC.view)
//    categoryVC.view.alpha = 0.0
//    
//    let imageView = createTransitionImageViewWithFrame(postListVC.heroView.frame)
//    imageView.image = postListVC.categoryHeroImage.image
//    context.containerView().addSubview(imageView)
//    
//    UIView.animateWithDuration(0.4, animations: {
//        postListVC.view.alpha = 0.0
//        postListVC.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
//        categoryVC.view.alpha = 1.0
//        categoryVC.tableView.frame.origin.y = self.originalTableViewY ?? categoryVC.tableView.frame.origin.y
//        imageView.alpha = 0.0
//        imageView.frame = self.selectedCellFrame ?? imageView.frame
//    }) { finished in
//        postListVC.view.transform = CGAffineTransformIdentity
//        imageView.removeFromSuperview()
//        context.completeTransition(!context.transitionWasCancelled())
//    }
//}
//
//
//
//
//func animateTransition(context: UIViewControllerContextTransitioning) {
//    // push
//    if let categoryVC = context.viewControllerForKey(UITransitionContextFromViewControllerKey) as? CategoryVC,
//        postListVC = context.viewControllerForKey(UITransitionContextToViewControllerKey) as? PostListVC {
//        moveFromCategories(categoryVC, toPosts:postListVC, withContext: context)
//    }
//        
//        // pop
//    else if let categoryVC = context.viewControllerForKey(UITransitionContextToViewControllerKey) as? CategoryVC,
//        postListVC = context.viewControllerForKey(UITransitionContextFromViewControllerKey) as? PostListVC {
//        moveFromPosts(postListVC, toCategories: categoryVC, withContext: context)
//    }
//}