//
//  ProgressHudShowable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol ProgressHudShowable: class {
    var progressHUD: MBProgressHUD? { get set }
    func configureProgressHUD()
    func showProgressHUD()
    func hideProgressHUD()
}

extension ProgressHudShowable where Self: UITableViewController {
    
    func configureProgressHUD() {
        progressHUD = MBProgressHUD.hudWithSize(CGSize(width: 40, height: 40), forFrame: tableView.bounds)
        tableView.addSubview(progressHUD!)
    }
    
    func showProgressHUD() {
        progressHUD?.show(false)
    }
    
    func hideProgressHUD() {
        progressHUD?.hide(false)
    }
    
}
