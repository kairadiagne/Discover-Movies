//
//  UILabel+currentNumberOfLines.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 26-02-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

extension UILabel {
    
    var currentNumberOfLines: Int {
        var lineCount = 0;
        let textSize = CGSize(width: self.frame.size.width, height: CGFloat(Float.infinity));
        let rHeight = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize = lroundf(Float(self.font.lineHeight));
        lineCount = rHeight/charSize
        return lineCount
    }
    
}
