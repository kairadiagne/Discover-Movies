//
//  DetailViewController\.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 11/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class DetailViewController: UIViewController {
    
    var detailView: DetailView { return view as! DetailView }
    
    var movie: TMDbMovie
    var image: UIImage?
    var imageURL: NSURL?
    
    // Collection view datasource [Similar movies]
    // Collection view datasource [
    
    // MARK: - Initialization 
    
    required init(movie: TMDbMovie, image: UIImage? = nil, imageURL url: NSURL? = nil) {
        self.movie = movie
        self.image = image
        self.imageURL = url
        super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure navigation bar 
        navigationController?.navigationBar.setAsTransparent()
        
        // Turn automatic adjustment of scrollViewInsets to navigation bar off
        automaticallyAdjustsScrollViewInsets = false
        
        // Conform to delegates and datasources collection views: Similar movies,
        
        // Fetch aditional information about movie
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Configure Detail View
        detailView.configureForMovie(movie, image: image!)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Reset navigationbar
        navigationController?.navigationBar.setAsUnclear()
    }

    // MARK: - Navigation
    
    private func showTrailer(movie: TMDbMovie) {
        
    }
    
    private func showReviews(movie: TMDbMovie) {
        
    }

}

