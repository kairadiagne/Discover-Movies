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
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }()
    
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
            
            if refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            } else {
                hideProgressHUD()
            }
        case .loading:
            self.state = .loading
            
            if !refreshControl.isRefreshing {
                showProgressHUD()
            }
        }
    }

}
