//
//  SearchResultsController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 11-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class SearchResultsController: UITableViewController, DataContaining {
    
    typealias ItemType = Movie
    
    // MARK: - Properties
    
    var items: [Movie] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib =  UINib(nibName: SearchTableViewCell.defaultIdentifier(), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.defaultIdentifier())
        
        clearsSelectionOnViewWillAppear = false
    }
  
}

// MARK: - UITableViewDelegate

extension SearchResultsController { // delegate is searchcontroller
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = item(atIndex: indexPath.row) else { return }
        _ = DetailViewController(movie: movie)
//        navigationController?.pushViewController(detailViewController, animated: false)
    }

}


// MARK: - UITableViewDataSource

extension SearchResultsController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.defaultIdentifier(), for: indexPath) as! SearchTableViewCell
        let movie = items[indexPath.row]
        let imageURL = TMDbImageRouter.posterSmall(path: movie.posterPath).url
        cell.configure(withMovie: movie, imageURL: imageURL)
        return cell
    }
    
}


