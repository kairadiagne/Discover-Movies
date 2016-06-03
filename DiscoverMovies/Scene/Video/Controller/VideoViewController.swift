//
//  VideoViewController.swift
//  
//
//  Created by Kaira Diagne on 12/05/16.
//
//

import UIKit
import TMDbMovieKit
import youtube_ios_player_helper
import MBProgressHUD

class VideoViewController: UIViewController, ProgressHUDPresentable {
    
    // MARK: Properties
    
    var progressHUD: MBProgressHUD?

    let youtubeView = YTPlayerView()
    
    var video: TMDbVideo!
    
    // MARK: Initialization
  
    required init(video: TMDbVideo) {
        super.init(nibName: nil, bundle: nil)
        
        self.video = video
        
        self.youtubeView.translatesAutoresizingMaskIntoConstraints = false
        self.youtubeView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(youtubeView)
        
        setupProgressHUD()
        
        youtubeView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 0).active = true
        youtubeView.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 0).active = true
        youtubeView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor, constant: 0).active = true
        youtubeView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: 0).active = true
        
        youtubeView.loadWithVideoId(video.source)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setAsUnclear()
    }
    
}

// MARK: YTPlayerViewDelegate

extension VideoViewController: YTPlayerViewDelegate {
    
    func playerViewPreferredInitialLoadingView(playerView: YTPlayerView) -> UIView? {
        let view = UIView()
        view.frame = self.view.bounds
        view.backgroundColor = UIColor.backgroundColor()
        showProgressHUD()
        return view
    }
    
    func playerViewPreferredWebViewBackgroundColor(playerView: YTPlayerView) -> UIColor {
        return UIColor.backgroundColor()
    }
    
    func playerViewDidBecomeReady(playerView: YTPlayerView) {
        hideProgressHUD()
    }
    
    func playerView(playerView: YTPlayerView, receivedError error: YTPlayerError) {
        print(error)
        // Handle the different errors that can occur: 
        // YTPayerError
        // - KYTPlayerErrorInvalidParam
        // - KYTPlayerErrorHTML5Error
        // - KYTPlayerErrorVideoNotFound
        // - KYTPlayerErrorNotEmbeddable
        // - KYTPlayerErrorUnknown
    }
    
}

