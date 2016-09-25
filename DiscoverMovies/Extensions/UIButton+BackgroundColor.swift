//
//  UIButton+BackgroundColor.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setBackground(color: UIColor, forState state: UIControlState, clipToBounds: Bool = true) {
        let rect = CGRect(x: 0, y:0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            
            context.setFillColor(color.cgColor)
            context.fill(rect)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            setBackgroundImage(image, for: state)
        }
    }
    
}
