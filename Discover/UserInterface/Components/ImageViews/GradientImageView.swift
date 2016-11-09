//
// GradientImageView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class GradientImageView: UIImageView {
    
    // MARK: - Properties

    fileprivate var gradientLayer = CAGradientLayer()
    
    var colors: [CGColor] = [UIColor.clear.cgColor, UIColor.backgroundColor().cgColor] {
        didSet {
            self.gradientLayer.colors = colors
        }
    }
    
    var startPoint = CGPoint.zero {
        didSet {
            self.gradientLayer.startPoint = startPoint
        }
    }
    
    var endPoint = CGPoint(x: 0, y: 1) {
        didSet {
            self.gradientLayer.endPoint = endPoint
        }
    }
    
    // MARK: - Initialize
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.gradientLayer.colors = colors
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
        self.layer.addSublayer(self.gradientLayer)
    }
    
    // MARK: - Life Cycle
    
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
