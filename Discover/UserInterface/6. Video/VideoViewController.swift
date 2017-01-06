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

protocol VideoViewControllerDelegate: class {
    func videoViewControllerDidFinish(_ controller: VideoViewController)
}

class VideoViewController: UIViewController {
    
    // MARK: - Properties
    
    var videoView: VideoView {
        return view as! VideoView
    }
    
    private let video: Video
    
    weak var delegate: VideoViewControllerDelegate?
    
    var videoPlayerIsBeingPresented: Bool = false
    
    // MARK: - Init
    
    init(video: Video) {
        self.video = video
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoView.youtubePlayerView.delegate = self
        
        let playerVars = ["playsinline": 0]
        videoView.youtubePlayerView.load(withVideoId: video.source, playerVars: playerVars)
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.hidesNavigationBarHairline = true
        
        let backSelector = #selector(VideoViewController.doneButtonCLick(button:))
        let barbuttontitle = NSLocalizedString("backButtonTitle", comment: "")
        let backButton = UIBarButtonItem(title: barbuttontitle, style: .plain, target: self, action: backSelector)
        backButton.tintColor = .white
        navigationController?.navigationBar.topItem?.leftBarButtonItem = backButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        videoPlayerIsBeingPresented = true
    }
    
    // MARK: - Rotation
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
    
    // MARK: - Navigation
    
    @objc private func doneButtonCLick(button: UIBarButtonItem) {
        // Reset video
        videoView.youtubePlayerView.stopVideo()
        delegate?.videoViewControllerDidFinish(self)
    }

}

extension VideoViewController: YTPlayerViewDelegate {
    
    public func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        videoView.stopLoading()
        videoView.youtubePlayerView.playVideo()
    }
    
    public func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        delegate?.videoViewControllerDidFinish(self)
    }
    
    public func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return .black
    }
    
    public func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        videoView.startLoading()
        return videoView.loadingOverlayView
    }

}



