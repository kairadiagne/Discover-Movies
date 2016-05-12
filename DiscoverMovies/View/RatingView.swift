//
//  RatingView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 07/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

enum RatingScale: Int {
    case FiveStar = 5
    case TenStar = 10
}

class RatingView: UIView {
    
    private struct Constants {
        static let Padding: CGFloat = 0.0
    }
    
    var rating: CGFloat?
    var scale: RatingScale!
    var starColor: UIColor?
    
    // MARK: - Initializer
    
    init(frame: CGRect, scale: RatingScale) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        
    }
    
    // MARK: - Drawing 
    
    override func drawRect(rect: CGRect) {
     // Draw the amount of stars on the screen 
     // Will be either 5 stars or 10 stars.
        
    for i in 0...scale.rawValue {
         // draw star
         // add proper spacing
    }
        
     
    }
    
    private func drawStarInRect(rect: CGRect) {
        
    }
    
    
    
    
    
    // draw ten stars next to eachother
    
    // Take care of proper spacing while drawing
    // Should size itself, but aspect ratio of stars should not change
    
    // property padding
    // property amount of stars
    // property rating
    // property color
    
    // Star Drawing
        // lenght of lines is always the same
        // Angle is always the same
    
    // Method for setting, updating the rating
    
    // A star can be filled a star can be empty inside
    
    // Base layer = A background with pattern image (in color of
    // Put a tranparent layer over the whole view {this is where we draw the stars
    
    // Based on the rating calculate (take into account the spacing) till where the
    // base layer should size itself. Until the point where we need to

   

}
