//
//  AnimatedShapeButton.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class AnimatedShapeButton: UIControl {
    
    // MARK: Types
    
    struct Constants {
        static let FillAnimationKey = "fillAnimation"
        static let GrowAnimationKey = "growAnimation"
        static let ShrinkAnimationKey = "shrinkAnimation"
        static let UnfillAnimationkey = "UnfillAnimation"
    }
    
    // MARK: Properties
    
    var shapeLayer = CAShapeLayer()
    
    var fillLayer = CAShapeLayer()
    
    var maskLayer = CAShapeLayer()
    
    var lineColor = UIColor.blueColor() {
        didSet {
            shapeLayer.strokeColor = lineColor.CGColor
            fillLayer.strokeColor = lineColor.CGColor
        }
    }
    
    var fillColor = UIColor.blueColor() {
        didSet {
            fillLayer.fillColor = lineColor.CGColor
        }
    }
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init(frame: CGRect, strokeColor: UIColor, fillColor: UIColor) {
        self.init(frame: frame)
        self.fillColor = fillColor
        self.lineColor = strokeColor
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.clearColor()
        self.setupLayers()
    }
    
    // MARK: Drawing
    
    func setupLayers() { } // Required for subclass
    
    // MARK: Touch events

    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        return true
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        super.endTrackingWithTouch(touch, withEvent: event)
        setSelectedState(!selected)
        sendActionsForControlEvents(.ValueChanged)
    }
    
    // MARK: Change State

    func setSelectedState(shouldBeSelected: Bool) {
        guard self.selected != shouldBeSelected else { return }
        
        if shouldBeSelected {
            changeFillAnimated(true, duration: 0.3, key: Constants.FillAnimationKey)
        } else if !shouldBeSelected {
            changeFillAnimated(false, duration: 0.3, key: Constants.UnfillAnimationkey)
        }
        
        self.selected = !self.selected
    }
    
    // MARK: Animation

    func changeFillAnimated(fill: Bool, duration: Double, key: String) {
        let unfilledRect = CGRect(x: bounds.width / 2, y: bounds.height / 2, width: 0, height: 0)
        let filledRect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
        
        let unfilledPath = UIBezierPath(ovalInRect: unfilledRect)
        let filledPath = UIBezierPath(ovalInRect: filledRect)
        
        let fillAnimation = CABasicAnimation(keyPath: "path")
        fillAnimation.delegate = self
        fillAnimation.fromValue = fill ? unfilledPath.CGPath : filledPath.CGPath
        fillAnimation.toValue = fill ? filledPath.CGPath : unfilledPath.CGPath
        fillAnimation.duration = duration
        fillAnimation.fillMode = kCAFillModeForwards
        fillAnimation.removedOnCompletion = false
        fillLayer.addAnimation(fillAnimation, forKey: Constants.FillAnimationKey)
    }
    
    func changeScaleAnimated(fromValue: CGFloat, toValue: CGFloat, duration: Double, key: String) {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.delegate = self
        scaleAnimation.fromValue = fromValue
        scaleAnimation.toValue = toValue
        scaleAnimation.duration = duration
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.removedOnCompletion = false
        self.layer.addAnimation(scaleAnimation, forKey: key)
    }
    
    // MARK: CABasicAnimation Delegate
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        if anim == fillLayer.animationForKey(Constants.FillAnimationKey) {
            changeScaleAnimated(1, toValue: 1.45, duration: 0.10, key: Constants.GrowAnimationKey)
        } else if anim == layer.animationForKey(Constants.GrowAnimationKey) {
            changeScaleAnimated(1.45, toValue: 1, duration: 0.10, key: Constants.ShrinkAnimationKey)
        }
    }

}
