//
//  ProgressHUDPresentable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol ProgressHUDPresentable {
    var progressHUD: MBProgressHUD { get }
    func showProgressHUD()
    func hideProgressHUD()
}

extension ProgressHUDPresentable where Self: UIView {
    
    var progressHUD: MBProgressHUD {
        let size = CGSize(width: 40, height: 40)
        let progressHUD = MBProgressHUD.hudWithSize(size, forFrame: bounds)
        progressHUD.isUserInteractionEnabled = false
        progressHUD.removeFromSuperViewOnHide = true
        return progressHUD
    }

    func showProgressHUD() {
        addSubview(progressHUD)
        progressHUD.show(animated: true)
    }
    
    func hideProgressHUD() {
        progressHUD.hide(animated: true)
    }
}

