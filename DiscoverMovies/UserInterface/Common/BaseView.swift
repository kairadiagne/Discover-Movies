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
    
    fileprivate(set) var state: State = .idle
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }()
    
    var activityIndicator: UIActivityIndicatorView?
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.backgroundColor()
    }

    // MARK: - State
    
    func set(state: State) {
        switch state {
        case .idle:
            self.state = .idle
            refreshControl.endRefreshing()
            activityIndicator?.stopAnimating()
            activityIndicator?.removeFromSuperview()
        case .loading:
            self.state = .loading
            
            if !refreshControl.isRefreshing && activityIndicator == nil {
                addRefreshControl()
                activityIndicator?.startAnimating()
            } 
        }
    }
    
    // MARK: - Utils
    
    func addRefreshControl() {
        activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator?.activityIndicatorViewStyle = .whiteLarge
        activityIndicator?.color = UIColor.gray
        
        addSubview(activityIndicator!)
        
        activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator?.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor).isActive = true
        activityIndicator?.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor).isActive = true
    }

}
