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
    
    // MARK: - Properties
    
    fileprivate(set) var state: State = .idle
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.backgroundColor()
    }
    
    // MARK: - Manage State
    
    func set(state: State) {
        switch state {
        case .idle:
            self.state = .idle
            hideProgressHUD()
        case .loading:
            self.state = .loading
            showProgressHUD()
        }
    }

}
