//
//  ProgressHUDPresentable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import MBProgressHUD

// MARK: - Protocol ProgressHUDPresentable

protocol ProgressHUDPresentable {
    var progressHUD: MBProgressHUD? { get set }
    func showProgressHUD()
    func hideProgressHUD() 
}

// MARK: - Default Implementation ProgressHUDPresentable

extension ProgressHUDPresentable where Self: UIViewController {
    
    func showProgressHUD() {
        progressHUD?.show(true)
    }
    
    func hideProgressHUD() {
        progressHUD?.hide(true)
    }
    
}

