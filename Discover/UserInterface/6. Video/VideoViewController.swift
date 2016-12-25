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

class VideoViewController: UIViewController {
    
    // MARK: - Properties
    
    private let youtubeView = YTPlayerView()
    
    private let video: Video
    
    // MARK: - Initialize
  
    required init(video: Video) {
        self.video = video
        
        super.init(nibName: nil, bundle: nil)
    
        self.view.addSubview(youtubeView)
        self.youtubeView.translatesAutoresizingMaskIntoConstraints = false
        self.youtubeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.youtubeView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.youtubeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.youtubeView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.youtubeView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        youtubeView.load(withVideoId: video.source)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let doneSelector = #selector(VideoViewController.doneButtonClick(notification:))
        NotificationCenter.default.addObserver(self, selector: doneSelector , name: NSNotification.Name.UIWindowDidBecomeHidden, object: view.window)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        youtubeView.playVideo()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIWindowDidBecomeHidden, object: view.window)
    }
    
    @objc fileprivate func doneButtonClick(notification: Notification) {
        youtubeView.stopVideo()
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Rotation
    
    
}

extension VideoViewController: YTPlayerViewDelegate {
    
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        let view = UIView()
        view.frame = self.view.bounds
        view.backgroundColor = UIColor.black
        return view
    }

    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return UIColor.black
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}

// TODO: - Better Error Handling
