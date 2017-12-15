//
//  UILayoutPriority+AddSubtract.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12-12-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

extension UILayoutPriority {

    static func + (lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        return UILayoutPriority(lhs.rawValue + rhs)
    }

    static func - (lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        return UILayoutPriority(lhs.rawValue - rhs)
    }

    static func += (lhs: inout UILayoutPriority, rhs: UILayoutPriority) {
        lhs = lhs + rhs.rawValue
    }

    static func -= (lhs: inout UILayoutPriority, rhs: UILayoutPriority) {
        lhs = lhs - rhs.rawValue
    }
}
