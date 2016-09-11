//
//  FavouriteButton.swift
//  FavouriteButton
//
//  Created by Kaira Diagne on 17/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class FavouriteButton: AnimatedShapeButton {
    
    // MARK: Properties

    fileprivate let lineWidth: CGFloat = 1.0
    
    // MARK: Generate Shape
    
    override func setupLayers() {
        // Generate the layer that shows the unfilled star. (This layer is always on screen)
        let starPath = generateStarPath(bounds.width, height: bounds.height)
        shapeLayer = CAShapeLayer()
        
        shapeLayer.frame = bounds
        shapeLayer.path = starPath.cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineJoin = kCALineCapRound
        
        // Generate the fill layer which will animate the filling
        let fillPath = generateFillPath(bounds.width, height: bounds.height)
        fillLayer = CAShapeLayer()
        
        // Generate the mask layer
        fillLayer.frame = bounds
        fillLayer.path = fillPath.cgPath
        fillLayer.fillColor = fillColor.cgColor
        fillLayer.lineJoin = kCALineCapRound
        
        // Create masklayer
        maskLayer = CAShapeLayer()
        maskLayer.path = generateStarPath(bounds.width, height: bounds.height).cgPath
        maskLayer.frame = self.bounds
        maskLayer.lineJoin = kCALineJoinRound
        
        layer.addSublayer(shapeLayer)
        layer.addSublayer(fillLayer)
        fillLayer.mask = maskLayer
    }
    
    // Generates a path shaped like a star
    
    fileprivate func generateStarPath(_ width: CGFloat, height: CGFloat) -> UIBezierPath {
        // Calulate start position
        let startX: CGFloat = width / 2
        let startY: CGFloat = 0
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: width * 0.35, y: height * 0.4))
        path.addLine(to: CGPoint(x: width * 0, y: path.currentPoint.y))
        path.addLine(to: CGPoint(x: width * 0.3, y: height * 0.6))
        path.addLine(to: CGPoint(x: width * 0.2, y: height))
        path.addLine(to: CGPoint(x: width * 0.5, y: height * 0.75))
        path.addLine(to: CGPoint(x: width * 0.8, y: height))
        path.addLine(to: CGPoint(x: width * 0.7, y: height * 0.6))
        path.addLine(to: CGPoint(x: width, y: height * 0.4))
        path.addLine(to: CGPoint(x: width * 0.65, y: path.currentPoint.y))
        path.close()
        
        return path
    }
    
    // Generates the path that will be used for the filling animation
    
    fileprivate func generateFillPath(_ wdith: CGFloat, height: CGFloat) -> UIBezierPath {
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let fillRect = CGRect(origin: centerPoint, size: CGSize(width: 0, height: 0)) // Before CGPoint.Zero
        return UIBezierPath(ovalIn: fillRect)
    }
    
}


