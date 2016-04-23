//
//  CosmosView+Configure.swift
//  
//
//  Created by Kaira Diagne on 20-02-16.
//
//

import UIKit
import Cosmos

extension CosmosView {
    
    func configureForRating(rating: Double?) {
        guard let rating = rating else { return }
        self.rating = rating
        text = String(format: "%.1f", arguments: [rating])
    }
    
    func setToDefaultStyle() {
        settings.totalStars = 10
        settings.starSize = 16
        settings.starMargin = 3
        settings.fillMode = .Half
        settings.updateOnTouch = false
        settings.emptyBorderColor = UIColor.flatSkyBlueColor()
        settings.emptyColor = UIColor.clearColor()
        settings.filledColor = UIColor.flatSkyBlueColor()
        settings.filledBorderColor = UIColor.flatSkyBlueColor()
        backgroundColor = UIColor.clearColor()
    }
    
}
