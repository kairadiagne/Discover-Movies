//
//  AnimatedShapeButton.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class AnimatedShapeButton: UIControl, CAAnimationDelegate {
    
    // MARK: - Types
    
    struct Constants {
        static let FillAnimationKey = "fillAnimation"
        static let GrowAnimationKey = "growAnimation"
        static let ShrinkAnimationKey = "shrinkAnimation"
        static let UnfillAnimationkey = "UnfillAnimation"
    }
    
    // MARK: - Properties
    
    var shapeLayer = CAShapeLayer()
    
    var fillLayer = CAShapeLayer()
    
    var maskLayer = CAShapeLayer()
    
    var lineColor = UIColor.blue {
        didSet {
            shapeLayer.strokeColor = lineColor.cgColor
            fillLayer.strokeColor = lineColor.cgColor
        }
    }
    
    var fillColor = UIColor.blue {
        didSet {
            fillLayer.fillColor = lineColor.cgColor
        }
    }
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.backgroundColor = UIColor.clear
    }

    // MARK: - Layoutcycle
    
    fileprivate var didAddLayers = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !didAddLayers {
            didAddLayers = true
            setupLayers()
        }
    }
    
    func setupLayers() {
    }
    
    // MARK: - Touch events

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        setSelectedState(!isSelected)
        sendActions(for: .valueChanged)
    }
    
    // MARK: - State

    func setSelectedState(_ shouldBeSelected: Bool) {
        guard self.isSelected != shouldBeSelected else { return }
        
        if shouldBeSelected {
            changeFillAnimated(true, duration: 0.3, key: Constants.FillAnimationKey)
        } else if !shouldBeSelected {
            changeFillAnimated(false, duration: 0.3, key: Constants.UnfillAnimationkey)
        }
        
        self.isSelected = !self.isSelected
    }
    
    // MARK: - Animations

    func changeFillAnimated(_ fill: Bool, duration: Double, key: String) {
        let unfilledRect = CGRect(x: bounds.width / 2, y: bounds.height / 2, width: 0, height: 0)
        let filledRect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
        
        let unfilledPath = UIBezierPath(ovalIn: unfilledRect)
        let filledPath = UIBezierPath(ovalIn: filledRect)
        
        let fillAnimation = CABasicAnimation(keyPath: "path")
        fillAnimation.delegate = self
        fillAnimation.fromValue = fill ? unfilledPath.cgPath : filledPath.cgPath
        fillAnimation.toValue = fill ? filledPath.cgPath : unfilledPath.cgPath
        fillAnimation.duration = duration
        fillAnimation.fillMode = kCAFillModeForwards
        fillAnimation.isRemovedOnCompletion = false
        fillLayer.add(fillAnimation, forKey: Constants.FillAnimationKey)
    }
    
    func changeScaleAnimated(_ fromValue: CGFloat, toValue: CGFloat, duration: Double, key: String) {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.delegate = self
        scaleAnimation.fromValue = fromValue
        scaleAnimation.toValue = toValue
        scaleAnimation.duration = duration
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.isRemovedOnCompletion = false
        self.layer.add(scaleAnimation, forKey: key)
    }
    
    // MARK: - CABasicAnimation Delegate
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if anim == fillLayer.animation(forKey: Constants.FillAnimationKey) {
            changeScaleAnimated(1, toValue: 1.45, duration: 0.10, key: Constants.GrowAnimationKey)
        } else if anim == layer.animation(forKey: Constants.GrowAnimationKey) {
            changeScaleAnimated(1.45, toValue: 1, duration: 0.10, key: Constants.ShrinkAnimationKey)
        }
    }

}
