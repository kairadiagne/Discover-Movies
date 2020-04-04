//
//  BaseView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    // MARK: - Types
    
    enum State {
        case idle
        case loading
    }
    
    // MARK: - Properties
    
    private(set) var state: State = .idle
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.tintColor = .white
        return refreshControl
    }()
    
    var activityIndicator: UIActivityIndicatorView?
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator?.style = .large
        activityIndicator?.color = .gray
        
        addSubview(activityIndicator!)
        
        activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator?.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor).isActive = true
        activityIndicator?.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor).isActive = true
    }

    // MARK: - State
    
    func set(state: State) {
        switch state {
        case .idle:
            self.state = .idle
            refreshControl.endRefreshing()
            activityIndicator?.stopAnimating()
        case .loading:
            self.state = .loading
            
            if !refreshControl.isRefreshing {
                activityIndicator?.startAnimating()
            } 
        }
    }
}
