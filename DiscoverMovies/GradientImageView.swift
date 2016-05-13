//
//  GradientImageView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class GradiedntView: UIView {
    
    private var gradientColors: [CGColor]!
    private var gradientLayer: CAGradientLayer!
    private var imageView: UIImageView!
    
    // MARK: - Initialization
    
    init(frame: CGRect, gradientColors colors: [CGColor]) {
        super.init(frame: frame)
        
        // Scales the content to fill the size of the view
        // Some potion of the content may be clipped to fill the view's bounds. 
//        self.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        
        // Add gradient layer
        self.gradientLayer = CAGradientLayer()
        self.gradientColors = colors
        self.gradientLayer.colors = gradientColors
        self.gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        self.gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        self.layer.addSublayer(gradientLayer)
        
        // Initialize imageview 
        self.imageView = UIImageView()
        self.imageView.contentMode = .ScaleToFill
        self.imageView.frame = frame
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Image
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = bounds
        self.frame = bounds
    }

}

class GradientView: UIImageView {
    
    private var gradientLayer: CAGradientLayer!
    
    init(frame: CGRect, gradientColors colors: [CGColor]) {
        super.init(frame: frame)
        self.contentMode = .ScaleAspectFill
        
        // Configure gradient layer
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.colors = colors
        self.gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        self.gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        self.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Resize Sub Layers
    
    // The default layer of UIView does resize its view, but wont do this for sublayers.
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        super.layoutSublayersOfLayer(layer)
        gradientLayer.frame = self.bounds
    }
    

}


