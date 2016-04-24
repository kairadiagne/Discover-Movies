//
//  ToplistTableViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import MBProgressHUD
import SDWebImage

class ToplistTableViewController: TMDbAuthorizationTableViewController, RevealMenuButtonShowable {
    
    private struct Storyboard {
        static let MovieCellIdentifier = "MovieCellIdentifier"
        static let MovieCellNibName = "MovieTableViewCell"
        static let ShowDetailSegueIdentifier = "ShowDetail"
    }
    
    @IBOutlet weak var switchListControl: UISegmentedControl!
    
    private let toplistCoordinator = ToplistCoordinator()
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        toplistCoordinator.delegate = self
        configureMenuButton()
        
        // Setup tableview
        let nib = UINib(nibName: Storyboard.MovieCellNibName , bundle: NSBundle.mainBundle())
        tableView.registerNib(nib, forCellReuseIdentifier: Storyboard.MovieCellIdentifier)
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Fetch list
        fetchTopList(switchListControl)
    }
    
    // MARK: - Toplist
    
    @IBAction func fetchTopList(sender: UISegmentedControl) {
        showProgressHUD()
        switch sender.selectedSegmentIndex {
        case 0:
            toplistCoordinator.fetchMoviesInTopList(TMDbToplist.Popular)
        case 1:
            toplistCoordinator.fetchMoviesInTopList(TMDbToplist.TopRated)
        case 2:
            toplistCoordinator.fetchMoviesInTopList(TMDbToplist.Upcoming)
        default:
            return
        }
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toplistCoordinator.items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.MovieCellIdentifier, forIndexPath: indexPath) as! MovieTableViewCell
        let movie = toplistCoordinator.items[indexPath.row]
        let imageURL = movie.backDropPath != nil ? TMDbImageRouter.BackDropMedium(path: movie.backDropPath!).url: nil
        cell.configure(movie, imageURL: imageURL)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        toplistCoordinator.fetchNextPageIfNeeded(indexPath.row)
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
                        let movie = toplistCoordinator.items[index.row]
                        destination.movie = movie
                    
                        if let path = movie.backDropPath, url = TMDbImageRouter.BackDropMedium(path: path).url{
                            if SDWebImageManager.sharedManager().cachedImageExistsForURL(url) == true {
                                let key = SDWebImageManager.sharedManager().cacheKeyForURL(url)
                                destination.image = SDImageCache.sharedImageCache().imageFromDiskCacheForKey(key)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
}
