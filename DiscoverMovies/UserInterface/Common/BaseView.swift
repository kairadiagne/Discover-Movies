//
//  BaseView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class BaseView: UIView, ProgressHUDPresentable {
    
    // MARK: - Types
    
    enum State {
        case idle
        case loading
    }
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.backgroundColor()
    }
    
    // MARK: - Manage State
    
    func set(state: State) {
        switch state {
        case .idle:
            hideProgressHUD()
        case .loading:
            showProgressHUD()
        }
    }
    
}
