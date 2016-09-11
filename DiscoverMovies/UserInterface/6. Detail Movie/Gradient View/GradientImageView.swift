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

    fileprivate(set) var gradientLayer = CAGradientLayer()
    var colors: [CGColor] = [UIColor.backgroundColor().cgColor, UIColor.clear.cgColor]
    var startPoint = CGPoint(x: 0, y: 1)
    var endPoint = CGPoint(x: 0, y: 0.1)
    
    // MARK: Initialize
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.gradientLayer.colors = colors
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
        self.layer.addSublayer(self.gradientLayer)
    }
    
    // MARK: Life Cycle
    
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

