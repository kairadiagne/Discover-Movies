//
//  Colors.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func backgroundColor() -> UIColor {
        return UIColor(red: 41/255, green: 47/255, blue: 51/255, alpha: 1.0)
    }

    static func buttonColor() -> UIColor {
        return UIColor(red: 162/255, green: 222/255, blue: 208/255, alpha: 0.8)
    }

    static func flatGray() -> UIColor {
        return UIColor(hue: 184 / 360, saturation: 10 / 100, brightness: 65 / 100, alpha: 1.0)
    }

    static func flatOrange() -> UIColor {
        return UIColor(hue: 28 / 360, saturation: 85 / 100, brightness: 90 / 100, alpha: 1.0)
    }

    static func flatRed() -> UIColor {
        return UIColor(hue: 6 / 360, saturation: 74 / 100, brightness: 91 / 100, alpha: 1.0)
    }
}
