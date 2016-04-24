//
//  HorizontalImageScroller.swift
//  Discover
//
//  Created by Kaira Diagne on 06-02-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

// MARK: - HorizontalImageScrollerDelegate

protocol HorizontalImageScrollerDelegate: class {
    func numberOfViewsForHorizontalImageScroller(scroller: HorizontalImageScroller) -> Int
    func horizontalImageScrollerViewAtIndex(scroller: HorizontalImageScroller, index: Int) -> UIImageView
    func horizontalImageScrollerClickedViewAtIndex(scroller: HorizontalImageScroller, index: Int)
}

class HorizontalImageScroller: UIView, UIScrollViewDelegate {
    
    struct Constants {
        static let Padding: CGFloat = 10.0
    }
    
    weak var delegate: HorizontalImageScrollerDelegate?
    private var scrollView: UIScrollView!
    private var views = [UIImageView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpScrollView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpScrollView()
    }

    private func setUpScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        addSubview(scrollView)
        
        let leading = self.scrollView.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor)
        let trailing = self.scrollView.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor)
        let top = self.scrollView.topAnchor.constraintEqualToAnchor(self.topAnchor)
        let bottom = self.scrollView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor)
        let height = self.scrollView.heightAnchor.constraintEqualToAnchor(self.heightAnchor)
        NSLayoutConstraint.activateConstraints([leading, trailing, top, bottom, height])
        
        let tapSelector = #selector(HorizontalImageScroller.tapped(_:))
        let tap = UITapGestureRecognizer(target: self, action: tapSelector)
        scrollView.addGestureRecognizer(tap)
    }
    
    // MARK: - Life Cycle
    
    // Gets called when the view is added to another view as subview.
    override func didMoveToSuperview() {
        loadViews()
    }
    
    func reloadData() {
        loadViews()
    }
    
    private func loadViews() {
        if let delegate = delegate {
            views = []
            for view in scrollView.subviews { view.removeFromSuperview() }
            
            var x: CGFloat = 0
            let y: CGFloat = 0
            var width: CGFloat = 0
            var height: CGFloat = 0
            
            for i in 0 ..< delegate.numberOfViewsForHorizontalImageScroller(self) {
                let imageView = delegate.horizontalImageScrollerViewAtIndex(self, index: i)
                width = imageView.frame.width
                height = imageView.frame.height
                x = CGFloat(i) * (Constants.Padding + width)
                imageView.frame.origin.x = x
                imageView.frame.origin.y = y
                self.scrollView.addSubview(imageView)
                views.append(imageView)
            }
            
            constrainViews(views, toView: scrollView)
            scrollView.contentSize = CGSize(width: x + width, height: height)
        }
    }
    
    private func constrainViews(views: [UIView], toView superView: UIView) {
        for view in views {
            superView.addConstraint(NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: superView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        }
    }
    
    // MARK: - Gestures
    
    // Finds out which view got tapped and informs the delegate
    func tapped(gesture: UITapGestureRecognizer) {
        guard let delegate = delegate else { return }
        let location = gesture.locationInView(gesture.view)
        for i in 0 ..< delegate.numberOfViewsForHorizontalImageScroller(self) {
            let view = scrollView.subviews[i]
            if CGRectContainsPoint(view.frame, location) {
                delegate.horizontalImageScrollerClickedViewAtIndex(self, index: i)
                break
            }
        }
    }
    
}


