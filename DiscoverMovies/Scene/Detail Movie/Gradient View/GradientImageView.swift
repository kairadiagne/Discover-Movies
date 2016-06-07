//
// GradientImageView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class GradientImageView: UIImageView {
    
    // MARK: Properties

    var gradientLayer = CAGradientLayer()
    
    var colors = [UIColor.backgroundColor().CGColor, UIColor.clearColor().CGColor]
    
    var startPoint = CGPoint(x: 0, y: 1)
    
    var endPoint = CGPoint(x: 0, y: 0.1)

        
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    convenience init(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint, frame: CGRect) {
        self.init(frame: frame)
        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.gradientLayer.colors = colors
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
        self.layer.addSublayer(self.gradientLayer)
    }
    
    // MARK: View Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Override default animation of properties layer.
        CATransaction.begin()
        // Actions triggered as a result of property changes made within this transaction group are supressed.
        CATransaction.setDisableActions(true)
        self.gradientLayer.frame = self.bounds
        // Commit all changes made during the current transaction
        CATransaction.commit()
    }
    
}

