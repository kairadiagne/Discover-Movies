//
// GradientImageView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

final class GradientImageView: UIImageView {
    
    // MARK: Properties

    private var gradientLayer = CAGradientLayer()
    
    var colors: [UIColor] = [UIColor.clear, UIColor.black] {
        didSet {
            gradientLayer.setNeedsDisplay()
        }
    }
    
    var startPoint: CGPoint = .zero {
        didSet {
            gradientLayer.startPoint = startPoint
        }
    }
    
    var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            gradientLayer.endPoint = endPoint
        }
    }
    
    private var currentBounds: CGRect = .zero
    private var currentColors: [CGColor] = []
    
    // MARK: Initialize
    
    init(frame: CGRect, colors: [UIColor]) {
        super.init(frame: frame)
        
        self.colors = colors
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        layer.addSublayer(gradientLayer)
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
    }
    
    // MARK: Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if currentBounds != bounds {
            currentBounds = bounds
            
            // Override default animation of properties layer.
            CATransaction.begin()
            // Actions triggered as a result of property changes made within this transaction group are supressed.
            CATransaction.setDisableActions(true)
            self.gradientLayer.frame = self.bounds
            // Commit all changes made during the current transaction
            CATransaction.commit()
        }
                    
        traitCollection.performAsCurrent {
            let newResolvedColors = self.colors.compactMap { $0.cgColor }
            guard currentColors != newResolvedColors else { return }
            self.gradientLayer.colors = newResolvedColors
        }
    }
}
