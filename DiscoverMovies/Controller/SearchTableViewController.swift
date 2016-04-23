//
//  SearchViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class SearchTableViewController: DiscoverBaseTableViewController {
    
    private struct Storyboard {
        static let MovieCellIdentifier = "MovieCellIdentifier"
        static let MovieCellNibName = "MovieTableViewCell"
        static let ShowDetailSegueIdentifier = "ShowDetail"
    }
    
    var discover: Discover? 
    var searchTitle: String?

    private let searchCoordinator = SearchCoordinator()
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        searchCoordinator.delegate = self
        
        // Set up table View
        let nib = UINib(nibName: Storyboard.MovieCellNibName , bundle: NSBundle.mainBundle())
        tableView.registerNib(nib, forCellReuseIdentifier: Storyboard.MovieCellIdentifier)
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableViewAutomaticDimension
        setupBackground(withMessage: "Did not find any movies that matched your requirements")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        showProgressHUD()
        if searchTitle != nil {
            searchCoordinator.searchMoviesBy(searchTitle!)
        } else {
            searchCoordinator.discoverMoviesBy(discover?.year, genre: discover?.genre, averageVote: discover?.vote)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCoordinator.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.MovieCellIdentifier, forIndexPath: indexPath) as! MovieTableViewCell
        let movie = searchCoordinator.items[indexPath.row]
        let imageURL = movie.backDropPath != nil ? TMDbImageRouter.BackDropMedium(path: movie.backDropPath!).url: nil
        cell.configure(movie, imageURL: imageURL)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        searchCoordinator.fetchNextPageIfNeeded(indexPath.row)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) else { return }
        performSegueWithIdentifier(Storyboard.ShowDetailSegueIdentifier, sender: cell)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.ShowDetailSegueIdentifier {
            if let destination = segue.destinationViewController as? DetailTableViewController {
                if let cell = sender as? UITableViewCell {
                    if let index = tableView.indexPathForCell(cell) {
                        destination.movie = searchCoordinator.items[index.row]
                        // Check if image exists in cache?
                        // destination.image = image from cache
                    }
                }
            }
        }
    }
    
}





        



