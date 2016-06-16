//
//  MBProgressHUD+Configure.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import MBProgressHUD

extension MBProgressHUD {
    
    static func hudWithSize(size: CGSize, forFrame frame: CGRect) -> MBProgressHUD {
        let point = CGPoint(x: (frame.width / 2) - (size.width / 2), y: (frame.height / 2) - (size.height / 2))
        let hud = MBProgressHUD(frame: CGRect(origin: point, size: size))
        return hud
    }
    
}
