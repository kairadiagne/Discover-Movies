//
//  VideoViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import youtube_ios_player_helper
import MBProgressHUD

class VideoViewController: UIViewController, ProgressHUDPresentable {
    
    // MARK: Properties
    
    var progressHUD: MBProgressHUD?
    
    let youtubeView = YTPlayerView()
    
    var video: Video!
    
    // MARK: Initialization
  
    required init(video: Video) {
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
        youtubeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        youtubeView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        youtubeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        youtubeView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        setupProgressHUD()
        
        youtubeView.load(withVideoId: video.source)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setAsUnclear()
    }
    
}

// MARK: YTPlayerViewDelegate

extension VideoViewController: YTPlayerViewDelegate {
    
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        let view = UIView()
        view.frame = self.view.bounds
        view.backgroundColor = UIColor.backgroundColor()
        showProgressHUD()
        return view
    }
    
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return UIColor.backgroundColor()
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        hideProgressHUD()
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        print(error)
        // Communicate to the user that an error has occured.
    }
    
}

