//
//  VideoView.swift
//  Discover
//
//  Created by Kaira Diagne on 30-12-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class VideoView: UIView {
    
    // MARK: - Properties 
    
    @IBOutlet weak var youtubePlayerView: YTPlayerView!
    @IBOutlet weak var loadingOverlayView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadingOverlayView.backgroundColor = .black
        loadingIndicator.activityIndicatorViewStyle = .whiteLarge
    }
    
    // MARK: - Video Controls
    
    func startLoading() {
        loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        loadingIndicator.stopAnimating()
    }
}
