//
//  GradientImageView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class GradientImageView: UIImageView {
    
    var colors: [CGColor]?
    var startPoint: CGPoint?
    var endPoint: CGPoint?
    
    private var gradientLayer: CAGradientLayer!
    
    init(gradientColors colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) {
        super.init(frame: CGRect.zero)
        
        // Configure gradient layer
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = frame
        self.gradientLayer.colors = colors
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
        self.layer.addSublayer(gradientLayer)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update the size of the gradient layer
        // Turns off the default animation of CALayer to prevent a noticeable lag. 
        // CATransaction class implements transition animations for a layer, and allows us
        // to override default animation properties that are set for animateable properties.
        CATransaction.begin()
        // Actions triggered as a result of property changes made within this transaction group are supressed.
        CATransaction.setDisableActions(true)
        self.gradientLayer.frame = self.bounds
        // Commit all changes made during the current transaction
        CATransaction.commit()
    }
    
}




