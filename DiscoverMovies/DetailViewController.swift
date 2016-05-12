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
    
    // 
    
    // Collection view datasource [Similar movies]
    // Collection view datasource [
    
    // MARK: - Initialization 
    
    required init(movie: TMDbMovie, image: UIImage? = nil) {
        self.movie = movie
        self.image = image
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
        
        // Conform to delegates and datasources collection views: Similar movies,
        
        // Configure the view
        detailView.configureForMovie(movie, image: image!)
        
        // Fetch aditional information about movie
        
    }

    // MARK: - Navigation
    
    private func showTrailer(movie: TMDbMovie) {
        
    }
    
    private func showReviews(movie: TMDbMovie) {
        
    }

}

