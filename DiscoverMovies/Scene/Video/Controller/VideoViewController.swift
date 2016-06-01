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

class VideoViewController: UIViewController {
    
    let youtubeView = YTPlayerView()
    
    var video: TMDbVideo!
    
    // MARK: - Initialization 
  
    required init(video: TMDbVideo) {
        super.init(nibName: nil, bundle: nil)
        self.video = video
        
        self.youtubeView.translatesAutoresizingMaskIntoConstraints = false
        self.youtubeView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(youtubeView)
        
        youtubeView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 0).active = true
        youtubeView.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 0).active = true
        youtubeView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor, constant: 0).active = true
        youtubeView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: 0).active = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setAsUnclear()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        youtubeView.loadWithVideoId(video.source)
    }
    
}

// MARK: - YTPlayerViewDelegate

extension VideoViewController: YTPlayerViewDelegate {
    
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
    
    func playerViewPreferredInitialLoadingView(playerView: YTPlayerView) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundColor()
        return view
    }
    
    func playerViewPreferredWebViewBackgroundColor(playerView: YTPlayerView) -> UIColor {
        return UIColor.backgroundColor()
    }
}

