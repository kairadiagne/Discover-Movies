//
//  WatchListButton.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class WatchListButton: AnimatedShapeButton {
    
    // MARK: Properties

    private let lineWidth: CGFloat = 1
    
    // MARK: Generate Shape
    
    override func setupLayers() {
        shapeLayer.frame = bounds
        shapeLayer.path = generateWatchListPath(bounds.width, height: bounds.height).CGPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = lineColor.CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineJoin = kCALineJoinRound
        
        let fillRect = CGRect(x: 0, y: bounds.height, width: bounds.width, height: 0)
        fillLayer.frame = bounds
        fillLayer.path = UIBezierPath(rect: fillRect).CGPath
        fillLayer.lineWidth = lineWidth
        fillLayer.strokeColor = lineColor.CGColor
        fillLayer.fillColor = fillColor.CGColor
        fillLayer.lineJoin = kCALineJoinRound
        
        maskLayer.frame = bounds
        maskLayer.path = generateWatchListPath(bounds.width, height: bounds.height).CGPath
        maskLayer.lineJoin = kCALineJoinRound
        
        layer.addSublayer(shapeLayer)
        layer.addSublayer(fillLayer)
        fillLayer.mask = maskLayer
    }
    
    private func generateWatchListPath(width: CGFloat, height: CGFloat) -> UIBezierPath {
        let rectangle = CGRect(x: 0, y: height * 0.1, width: width * 0.85, height: height * 0.15)
        let rectanglePath = UIBezierPath(rect: rectangle)
        
        let rectangle2 = CGRect(x: 0, y: height * 0.4, width: width * 0.85, height: height * 0.15)
        let rectanglePath2 = UIBezierPath(rect: rectangle2)
        
        let rectangle3 = CGRect(x: 0, y: height * 0.7, width: width * 0.5, height: height * 0.15)
        let rectanglePath3 = UIBezierPath(rect: rectangle3)
        
        let plusPath = UIBezierPath()
        plusPath.moveToPoint(CGPoint(x: width * 0.7, y: height * 0.65))
        plusPath.addLineToPoint(CGPoint(x: plusPath.currentPoint.x, y: height * 0.75))
        plusPath.addLineToPoint(CGPoint(x: width * 0.6 , y: plusPath.currentPoint.y))
        plusPath.addLineToPoint(CGPoint(x: plusPath.currentPoint.x, y: height * 0.85))
        plusPath.addLineToPoint(CGPoint(x: width * 0.7, y: plusPath.currentPoint.y))
        plusPath.addLineToPoint(CGPoint(x: plusPath.currentPoint.x, y: height * 0.95))
        plusPath.addLineToPoint(CGPoint(x: width * 0.8, y: plusPath.currentPoint.y))
        plusPath.addLineToPoint(CGPoint(x: plusPath.currentPoint.x, y: height * 0.85))
        plusPath.addLineToPoint(CGPoint(x: width * 0.9, y: plusPath.currentPoint.y))
        plusPath.addLineToPoint(CGPoint(x: plusPath.currentPoint.x, y: height * 0.75))
        plusPath.addLineToPoint(CGPoint(x: width * 0.8, y: plusPath.currentPoint.y))
        plusPath.addLineToPoint(CGPoint(x: plusPath.currentPoint.x, y: height * 0.65))
        plusPath.addLineToPoint(CGPoint(x: width * 0.7, y: plusPath.currentPoint.y))
        
        // Join paths into one shape
        rectanglePath.appendPath(rectanglePath2)
        rectanglePath.appendPath(rectanglePath3)
        rectanglePath.appendPath(plusPath)
        
        return rectanglePath
    }
    
    // MARK: Animation
    
    override func changeFillAnimated(fill: Bool, duration: Double, key: String) {
        let unfilledRect = CGRect(x: bounds.width / 2, y: bounds.height / 2, width: 0, height: 0)
        let filledRect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
        
        let unfilledPath = UIBezierPath(rect: unfilledRect)
        let filledPath = UIBezierPath(rect: filledRect)
        
        let fillAnimation = CABasicAnimation(keyPath: "path")
        fillAnimation.delegate = self
        fillAnimation.fromValue = fill ? unfilledPath.CGPath : filledPath.CGPath
        fillAnimation.toValue = fill ? filledPath.CGPath : unfilledPath.CGPath
        fillAnimation.duration = duration
        fillAnimation.fillMode = kCAFillModeForwards
        fillAnimation.removedOnCompletion = false
        fillLayer.addAnimation(fillAnimation, forKey: Constants.FillAnimationKey)
    }

}
