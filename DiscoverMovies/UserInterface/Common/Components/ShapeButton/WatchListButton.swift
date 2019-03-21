//
//  WatchListButton.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class WatchListButton: AnimatedShapeButton {
    
    // MARK: - Properties

    private let lineWidth: CGFloat = 1
    
    // MARK: - Generate Shape
    
    override func setupLayers() {
        shapeLayer.frame = bounds
        shapeLayer.path = generateWatchListPath(bounds.width, height: bounds.height).cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        
        let fillRect = CGRect(x: 0, y: bounds.height, width: bounds.width, height: 0)
        fillLayer.frame = bounds
        fillLayer.path = UIBezierPath(rect: fillRect).cgPath
        fillLayer.lineWidth = lineWidth
        fillLayer.strokeColor = lineColor.cgColor
        fillLayer.fillColor = fillColor.cgColor
        fillLayer.lineJoin = CAShapeLayerLineJoin.round
        
        maskLayer.frame = bounds
        maskLayer.path = generateWatchListPath(bounds.width, height: bounds.height).cgPath
        maskLayer.lineJoin = CAShapeLayerLineJoin.round
        
        layer.addSublayer(shapeLayer)
        layer.addSublayer(fillLayer)
        fillLayer.mask = maskLayer
    }
    
    private func generateWatchListPath(_ width: CGFloat, height: CGFloat) -> UIBezierPath {
        let rectangle = CGRect(x: 0, y: height * 0.1, width: width * 0.85, height: height * 0.15)
        let rectanglePath = UIBezierPath(rect: rectangle)
        
        let rectangle2 = CGRect(x: 0, y: height * 0.4, width: width * 0.85, height: height * 0.15)
        let rectanglePath2 = UIBezierPath(rect: rectangle2)
        
        let rectangle3 = CGRect(x: 0, y: height * 0.7, width: width * 0.5, height: height * 0.15)
        let rectanglePath3 = UIBezierPath(rect: rectangle3)
        
        let plusPath = UIBezierPath()
        plusPath.move(to: CGPoint(x: width * 0.7, y: height * 0.65))
        plusPath.addLine(to: CGPoint(x: plusPath.currentPoint.x, y: height * 0.75))
        plusPath.addLine(to: CGPoint(x: width * 0.6, y: plusPath.currentPoint.y))
        plusPath.addLine(to: CGPoint(x: plusPath.currentPoint.x, y: height * 0.85))
        plusPath.addLine(to: CGPoint(x: width * 0.7, y: plusPath.currentPoint.y))
        plusPath.addLine(to: CGPoint(x: plusPath.currentPoint.x, y: height * 0.95))
        plusPath.addLine(to: CGPoint(x: width * 0.8, y: plusPath.currentPoint.y))
        plusPath.addLine(to: CGPoint(x: plusPath.currentPoint.x, y: height * 0.85))
        plusPath.addLine(to: CGPoint(x: width * 0.9, y: plusPath.currentPoint.y))
        plusPath.addLine(to: CGPoint(x: plusPath.currentPoint.x, y: height * 0.75))
        plusPath.addLine(to: CGPoint(x: width * 0.8, y: plusPath.currentPoint.y))
        plusPath.addLine(to: CGPoint(x: plusPath.currentPoint.x, y: height * 0.65))
        plusPath.addLine(to: CGPoint(x: width * 0.7, y: plusPath.currentPoint.y))
        
        rectanglePath.append(rectanglePath2)
        rectanglePath.append(rectanglePath3)
        rectanglePath.append(plusPath)
        
        return rectanglePath
    }
    
    // MARK: - Animation
    
    override func changeFillAnimated(_ fill: Bool, duration: Double, key: String) {
        let unfilledRect = CGRect(x: bounds.width / 2, y: bounds.height / 2, width: 0, height: 0)
        let filledRect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
        
        let unfilledPath = UIBezierPath(rect: unfilledRect)
        let filledPath = UIBezierPath(rect: filledRect)
        
        let fillAnimation = CABasicAnimation(keyPath: "path")
        fillAnimation.delegate = self
        fillAnimation.fromValue = fill ? unfilledPath.cgPath : filledPath.cgPath
        fillAnimation.toValue = fill ? filledPath.cgPath : unfilledPath.cgPath
        fillAnimation.duration = duration
        fillAnimation.fillMode = CAMediaTimingFillMode.forwards
        fillAnimation.isRemovedOnCompletion = false
        fillLayer.add(fillAnimation, forKey: Constants.FillAnimationKey)
    }
}
