//
//  WatchListView.swift
//  Discover
//
//  Created by Kaira Diagne on 29-02-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class WatchListView: UpdateListView {
    
    override var identifier: String { return "watchlist" }
    
    override func drawRect(rect: CGRect) {
        drawWatchList(rect)
    }

    func drawWatchList(frame: CGRect) {
        // Draw rectangles
        let rectanglePath = UIBezierPath(roundedRect: CGRectMake(frame.minX + floor(frame.width * 0.10000 + 0.5), frame.minY + floor((frame.height - 3) * 0.20000 + 0.5), floor(frame.width * 0.50000 + 0.5) - floor(frame.width * 0.10000 + 0.5), floor(frame.height * 0.88889 + 0.5) - floor(frame.height * 0.72222 + 0.5)), cornerRadius: 1.5)
      
        let rectangle2Path = UIBezierPath(roundedRect: CGRectMake(frame.minX + floor(frame.width * 0.10000 + 0.5), frame.minY + floor(frame.height * 0.44444 + 0.5), floor(frame.width * 0.50000 + 0.5) - floor(frame.width * 0.10000 + 0.5), floor(frame.height * 0.88889 + 0.5) - floor(frame.height * 0.72222 + 0.5)), cornerRadius: 1.5)
        
        let rectangle3Path = UIBezierPath(roundedRect: CGRectMake(frame.minX + floor(frame.width * 0.10000 + 0.5), frame.minY + floor(frame.height * 0.72222 + 0.5), floor(frame.width * 0.50000 + 0.5) - floor(frame.width * 0.10000 + 0.5), floor(frame.height * 0.88889 + 0.5) - floor(frame.height * 0.72222 + 0.5)), cornerRadius: 1.5)
        
        // Plus sign
        let plusPath = UIBezierPath()
        plusPath.moveToPoint(CGPointMake(frame.minX + 0.83333 * frame.width, frame.minY + 0.25000 * frame.height))
        plusPath.addCurveToPoint(CGPointMake(frame.minX + 0.83333 * frame.width, frame.minY + 0.44444 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.83333 * frame.width, frame.minY + 0.25000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.83333 * frame.width, frame.minY + 0.34047 * frame.height))
        plusPath.addLineToPoint(CGPointMake(frame.minX + 0.91667 * frame.width, frame.minY + 0.44444 * frame.height))
        plusPath.addCurveToPoint(CGPointMake(frame.minX + 0.96667 * frame.width, frame.minY + 0.52778 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.94428 * frame.width, frame.minY + 0.44444 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.96667 * frame.width, frame.minY + 0.48175 * frame.height))
        plusPath.addCurveToPoint(CGPointMake(frame.minX + 0.91667 * frame.width, frame.minY + 0.61111 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.96667 * frame.width, frame.minY + 0.57380 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.94428 * frame.width, frame.minY + 0.61111 * frame.height))
        plusPath.addLineToPoint(CGPointMake(frame.minX + 0.83333 * frame.width, frame.minY + 0.61111 * frame.height))
        plusPath.addCurveToPoint(CGPointMake(frame.minX + 0.83333 * frame.width, frame.minY + 0.75000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.83333 * frame.width, frame.minY + 0.68977 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.83333 * frame.width, frame.minY + 0.75000 * frame.height))
        plusPath.addCurveToPoint(CGPointMake(frame.minX + 0.78333 * frame.width, frame.minY + 0.83333 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.83333 * frame.width, frame.minY + 0.79602 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.81095 * frame.width, frame.minY + 0.83333 * frame.height))
        plusPath.addCurveToPoint(CGPointMake(frame.minX + 0.73333 * frame.width, frame.minY + 0.75000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.75572 * frame.width, frame.minY + 0.83333 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.73333 * frame.width, frame.minY + 0.79602 * frame.height))
        plusPath.addCurveToPoint(CGPointMake(frame.minX + 0.73333 * frame.width, frame.minY + 0.61111 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.73333 * frame.width, frame.minY + 0.75000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.73333 * frame.width, frame.minY + 0.68977 * frame.height))
        plusPath.addLineToPoint(CGPointMake(frame.minX + 0.61667 * frame.width, frame.minY + 0.61111 * frame.height))
        plusPath.addCurveToPoint(CGPointMake(frame.minX + 0.56667 * frame.width, frame.minY + 0.52778 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.58905 * frame.width, frame.minY + 0.61111 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.56667 * frame.width, frame.minY + 0.57380 * frame.height))
        plusPath.addCurveToPoint(CGPointMake(frame.minX + 0.61667 * frame.width, frame.minY + 0.44444 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.56667 * frame.width, frame.minY + 0.48175 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.58905 * frame.width, frame.minY + 0.44444 * frame.height))
        plusPath.addLineToPoint(CGPointMake(frame.minX + 0.73333 * frame.width, frame.minY + 0.44444 * frame.height))
        plusPath.addCurveToPoint(CGPointMake(frame.minX + 0.73333 * frame.width, frame.minY + 0.25000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.73333 * frame.width, frame.minY + 0.34047 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.73333 * frame.width, frame.minY + 0.25000 * frame.height))
        plusPath.addCurveToPoint(CGPointMake(frame.minX + 0.78333 * frame.width, frame.minY + 0.16667 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.73333 * frame.width, frame.minY + 0.20398 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.75572 * frame.width, frame.minY + 0.16667 * frame.height))
        plusPath.addCurveToPoint(CGPointMake(frame.minX + 0.83333 * frame.width, frame.minY + 0.25000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.81095 * frame.width, frame.minY + 0.16667 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.83333 * frame.width, frame.minY + 0.20398 * frame.height))
        plusPath.closePath()
        
        fillColor.setFill()
        borderColor.setStroke()
        
        rectanglePath.lineWidth = lineWidth
        rectangle2Path.lineWidth = lineWidth
        rectangle3Path.lineWidth = lineWidth
        plusPath.lineWidth = lineWidth
        
        rectangle2Path.miterLimit = 4
        rectangle2Path.miterLimit = 4
        rectangle3Path.miterLimit = 4
        plusPath.miterLimit = 4
        
        rectanglePath.stroke()
        rectangle2Path.stroke()
        rectangle3Path.stroke()
        plusPath.stroke()
        
        if inList {
            rectanglePath.fill()
            rectangle2Path.fill()
            rectangle3Path.fill()
            plusPath.fill()
        }
    }
    
}

