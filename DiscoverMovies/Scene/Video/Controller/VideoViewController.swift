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
    
    @IBOutlet weak var youtubeVideoView: YTPlayerView!
    
    var video: TMDbVideo
    
    // MARK: - Initialization 
    
    required init(video: TMDbVideo) {
        self.video = video
        super.init(nibName: "VideoViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youtubeVideoView.delegate = self
        playVideo()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setAsUnclear()
    }
    
    private func playVideo() {
        guard let youtubeID = video.key else {
            showAlertWithTitle("Trailer unavailable", message: "Couldn't find the trailer for this movie", completionHandler: { _ in
                self.navigationController?.popToRootViewControllerAnimated(false)
            })
            return
        }
        youtubeVideoView.loadWithVideoId(youtubeID)
    }
    
}

// MARK: - YTPlayerViewDelegate

extension VideoViewController: YTPlayerViewDelegate {
    
    func playerView(playerView: YTPlayerView, receivedError error: YTPlayerError) {
        print(error)
    }
}

