//
//  FavoriteView.swift
//  
//
//  Created by Kaira Diagne on 27-02-16.
//
//

import UIKit

class FavoriteView: UpdateListView {
    
    // MARK: - Properties
    
    override var identifier: String { return "favorite" }
    
    // MARK: - Drawing
    
    override func drawRect(rect: CGRect) {
        drawHeart(rect)
    }
    
    private func drawHeart(frame: CGRect) {
        let heartPath = UIBezierPath()
        heartPath.moveToPoint(CGPointMake(frame.minX + 0.69853 * frame.width, frame.minY + 0.05556 * frame.height))
        heartPath.addCurveToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.16176 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.61940 * frame.width, frame.minY + 0.05556 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.54682 * frame.width, frame.minY + 0.09570 * frame.height))
        heartPath.addCurveToPoint(CGPointMake(frame.minX + 0.30147 * frame.width, frame.minY + 0.05556 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.45318 * frame.width, frame.minY + 0.09570 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.38060 * frame.width, frame.minY + 0.05556 * frame.height))
        heartPath.addCurveToPoint(CGPointMake(frame.minX + 0.05051 * frame.width, frame.minY + 0.32920 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.16311 * frame.width, frame.minY + 0.05556 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.05051 * frame.width, frame.minY + 0.17828 * frame.height))
        heartPath.addCurveToPoint(CGPointMake(frame.minX + 0.12050 * frame.width, frame.minY + 0.51875 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.05051 * frame.width, frame.minY + 0.40009 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.07532 * frame.width, frame.minY + 0.46742 * frame.height))
        heartPath.addLineToPoint(CGPointMake(frame.minX + 0.47448 * frame.width, frame.minY + 0.93603 * frame.height))
        heartPath.addLineToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.94444 * frame.height))
        heartPath.addLineToPoint(CGPointMake(frame.minX + 0.52552 * frame.width, frame.minY + 0.93603 * frame.height))
        heartPath.addLineToPoint(CGPointMake(frame.minX + 0.87271 * frame.width, frame.minY + 0.54565 * frame.height))
        heartPath.addCurveToPoint(CGPointMake(frame.minX + 0.94949 * frame.width, frame.minY + 0.33897 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.92187 * frame.width, frame.minY + 0.49407 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.94949 * frame.width, frame.minY + 0.41418 * frame.height))
        heartPath.addCurveToPoint(CGPointMake(frame.minX + 0.69853 * frame.width, frame.minY + 0.05556 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.94949 * frame.width, frame.minY + 0.18804 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.83689 * frame.width, frame.minY + 0.05556 * frame.height))
        heartPath.addLineToPoint(CGPointMake(frame.minX + 0.69853 * frame.width, frame.minY + 0.05556 * frame.height))
        heartPath.closePath()
        heartPath.miterLimit = 4;
        
        borderColor.setStroke()
        heartPath.lineWidth = lineWidth
        heartPath.stroke()
        
        if inList {
            fillColor.setFill()
            heartPath.fill()
        }
    }
    
}
