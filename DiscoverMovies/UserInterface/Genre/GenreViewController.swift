//
//  GenreViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class GenreViewController: BaseViewController {
    
    // MARK: - Properties 
    
    let dataManager = GenreManager()
    
    let dataSource = GenreDataSource()
    
    // MARK: - Life cyce

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}
