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

protocol ProgressHUDPresentable: class {
    var progressHUD: MBProgressHUD? { get set }
    func setupProgressHUD()
    func showProgressHUD()
    func hideProgressHUD() 
}

// MARK: - Default Implementation ProgressHUDPresentable

extension ProgressHUDPresentable where Self: UIViewController {
    
    func setupProgressHUD() {
        progressHUD = MBProgressHUD.hudWithSize(CGSize(width: 40, height: 40), forFrame: view.bounds)
        progressHUD?.isUserInteractionEnabled = false 
        view.addSubview(progressHUD!)
    }
    
    func showProgressHUD() {
        progressHUD?.show(animated: true)
    }
    
    func hideProgressHUD() {
        progressHUD?.hide(animated: true)
    }
    
}

