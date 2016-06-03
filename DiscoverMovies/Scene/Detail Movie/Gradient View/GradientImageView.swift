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

    var gradientLayer: CAGradientLayer!
        
    // MARK: Initializers
    
    init(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint, frame: CGRect) {
        super.init(frame: frame)

        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = frame
        self.gradientLayer.colors = colors
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
        self.layer.addSublayer(self.gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

