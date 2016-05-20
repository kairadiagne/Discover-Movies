//
//  FavouriteButton.swift
//  FavouriteButton
//
//  Created by Kaira Diagne on 17/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class FavouriteButton: AnimatedShapeButton {

    private let lineWidth: CGFloat = 1.0
    
    // MARK: - Drawing 
    
    override func setupLayers() {
        // Generate the layer that shows the unfilled star. (This layer is always on screen)
        let starPath = generateStarPath(bounds.width, height: bounds.height)
        shapeLayer = CAShapeLayer()
        
        shapeLayer.frame = bounds
        shapeLayer.path = starPath.CGPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = lineColor.CGColor
        shapeLayer.lineJoin = kCALineCapRound
        
        // Generate the fill layer which will animate the filling
        let fillPath = generateFillPath(bounds.width, height: bounds.height)
        fillLayer = CAShapeLayer()
        
        // Generate the mask layer
        fillLayer.frame = bounds
        fillLayer.path = fillPath.CGPath
        fillLayer.fillColor = fillColor.CGColor
        fillLayer.lineJoin = kCALineCapRound
        
        // Create masklayer
        maskLayer = CAShapeLayer()
        maskLayer.path = generateStarPath(bounds.width, height: bounds.height).CGPath
        maskLayer.frame = self.bounds
        maskLayer.lineJoin = kCALineJoinRound
        
        layer.addSublayer(shapeLayer)
        layer.addSublayer(fillLayer)
        fillLayer.mask = maskLayer
    }
    
    // Generates a path shaped like a star
    
    private func generateStarPath(width: CGFloat, height: CGFloat) -> UIBezierPath {
        // Calulate start position
        let startX: CGFloat = width / 2
        let startY: CGFloat = 0
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: startX, y: startY))
        path.addLineToPoint(CGPoint(x: width * 0.35, y: height * 0.4))
        path.addLineToPoint(CGPoint(x: width * 0, y: path.currentPoint.y))
        path.addLineToPoint(CGPoint(x: width * 0.3, y: height * 0.6))
        path.addLineToPoint(CGPoint(x: width * 0.2, y: height))
        path.addLineToPoint(CGPoint(x: width * 0.5, y: height * 0.75))
        path.addLineToPoint(CGPoint(x: width * 0.8, y: height))
        path.addLineToPoint(CGPoint(x: width * 0.7, y: height * 0.6))
        path.addLineToPoint(CGPoint(x: width, y: height * 0.4))
        path.addLineToPoint(CGPoint(x: width * 0.65, y: path.currentPoint.y))
        path.closePath()
        
        return path
    }
    
    // Generates the path that will be used for the filling animation
    
    private func generateFillPath(wdith: CGFloat, height: CGFloat) -> UIBezierPath {
        let centerPoint = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
        let fillRect = CGRect(origin: centerPoint, size: CGSize(width: 0, height: 0)) // Before CGPoint.Zero
        return UIBezierPath(ovalInRect: fillRect)
    }
    
}


