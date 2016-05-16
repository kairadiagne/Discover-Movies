//
//  FavoriteButton.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class FavoriteButton: CustomButton {

    
    // Star path large 
    // Star path small 
    // expand animation from smal to large to small ?? CABasic animation 
//    expandanimation.fillMode = kCAFillModeForwards Choose the option which means it will go back to its normal size
//    expandanimation.removedOnCompletion = false // It should stay on the screen 
    
    // Sequence of animations can be done with a caanimationgroup that takes a couple CA basic animations
//     Finally, you apply the CAAnimationGroup to the layer and instruct it to not be removed on completion so it will retain its state when the animation has finished
    
   // MARK: - Custom Drawing 
    
    override func drawRect(rect: CGRect) {
        
    }

}
