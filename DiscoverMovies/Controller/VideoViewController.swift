//
//  VideoViewController.swift
//  Discover
//
//  Created by Kaira Diagne on 11-02-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import youtube_ios_player_helper

class VideoViewController: UIViewController {
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    var video: TMDbVideo?
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setAsUnclear()
    }
    
    private func playVideo() {
        guard let youtubeID = video?.key else {
            showAlertWithTitle("Error", message: "Could not play video", completionHandler: { _ in
                self.navigationController?.popToRootViewControllerAnimated(true)
            })
            return
        }
        playerView.loadWithVideoId(youtubeID)
    }
    
}

// MARK: - YTPlayerViewDelegate

extension VideoViewController: YTPlayerViewDelegate {
    
    func playerView(playerView: YTPlayerView, receivedError error: YTPlayerError) {
        print(error)
    }
}
