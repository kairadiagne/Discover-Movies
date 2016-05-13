////
////  DetailTableViewController.swift
////  DiscoverMovies
////
////  Created by Kaira Diagne on 20-04-16.
////  Copyright © 2016 Kaira Diagne. All rights reserved.
////
//
//import UIKit
//import TMDbMovieKit
//import SDWebImage
//
//class DetailTableViewController: DiscoverBaseTableViewController, AuthorizationErrorHandlerProtocol {
//    
//    private struct Constants {
//        static let DetailCellIdentifier = "DetailCellTableViewCell"
//        static let DetailTableViewVCIdentifier = "DetailTableViewController"
//        static let WatchTrailerSegueIdentifier = "WatchTrailer"
//        static let ShowReviewsSegueIdentifier = "ReadReviews"
//        static let SimilarImageViewHeight: CGFloat = 160
//        static let SimilarImageViewWidthRatio: CGFloat = 0.67
//    }
//    
//    private let detailCoordinator = DetailCoordinator()
//    
//    var movie: TMDbMovie? {
//        didSet {
//            tableView.reloadData()
//            detailCoordinator.delegate = self
//            if let movieID = movie?.movieID {
//              detailCoordinator.fetchSimilarMovies(movieID)
//              detailCoordinator.getAccountStates(movieID) 
//              detailCoordinator.fetchTrailer(movieID)
//            }
//        }
//    }
//    
//    var image: UIImage? {
//        didSet {
//            tableView.reloadData()
//        }
//    }
//    
//    // MARK: - View Controller Life Cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.separatorStyle = .None
//        tableView.estimatedRowHeight = 800
//        tableView.rowHeight = UITableViewAutomaticDimension
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if let detailCell = tableView.visibleCells.first as? DetailTableViewCell {
//            detailCell.prepareAnimation()
//        }
//    }
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        if let detailCell = tableView.visibleCells.first as? DetailTableViewCell {
//            detailCell.animate()
//        }
//        
//    }
//        
//    // MARK: - UITableViewDataSource
//    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.DetailCellIdentifier, forIndexPath: indexPath) as! DetailTableViewCell
//        guard let movie = movie else { return cell }
//        
//        cell.similarMoviesScroller.delegate = self
//        cell.favoriteView.delegate = self
//        cell.watchListView.delegate = self
//        
//        let backDropPath = movie.backDropPath ?? ""
//        let url = TMDbImageRouter.BackDropMedium(path: backDropPath).url ?? nil
//        cell.configure(movie, image: image, url: url)
//        cell.configureForAccountState(detailCoordinator.inFavorites, inWatchList: detailCoordinator.inWatchList)
//    
//        return cell
//    }
//    
//    // MARK: UITableViewDelegate
//    
//    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }
//    
//    // MARK: - ItemCoordinatorDelegate
//    
//    override func coordinatorDidReceiveError(error: NSError) {
//        super.coordinatorDidReceiveError(error)
//        detectAuthorizationError(error)
//    }
//    
//    func handleAuthorizationError() {
//        
//    }
//    
//    // MARK: - Navigation
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == Constants.WatchTrailerSegueIdentifier {
//            if let destination = segue.destinationViewController as? VideoViewController {
//                destination.video = detailCoordinator.trailer
//            }
//        } else if segue.identifier == Constants.ShowReviewsSegueIdentifier {
//            if let destination = segue.destinationViewController as? ReviewTableViewController {
//                destination.movie = movie
//            }
//        }
//    }
//    
//}
//
//// MARK: - HorizontalImageScrollerDelegate
//
//extension DetailTableViewController: HorizontalImageScrollerDelegate {
//    
//    func numberOfViewsForHorizontalImageScroller(scroller: HorizontalImageScroller) -> Int {
//        return detailCoordinator.items.count
//    }
//    
//    func horizontalImageScrollerViewAtIndex(scroller: HorizontalImageScroller, index: Int) -> UIImageView {
//        let width = Constants.SimilarImageViewHeight * Constants.SimilarImageViewWidthRatio
//        let imageRect = CGRect(x: 0, y: 0, width: width, height: Constants.SimilarImageViewHeight)
//        let imageView = UIImageView(frame: imageRect)
//        let movie = detailCoordinator.items[index]
//        guard let posterPath = movie.posterPath else { return imageView }
//        let url = TMDbImageRouter.PosterMedium(path: posterPath).url ?? nil
//        imageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
//        return imageView
//    }
//    
//    func horizontalImageScrollerClickedViewAtIndex(scroller: HorizontalImageScroller, index: Int) {
//        let movie = detailCoordinator.items[index]
//        let destination = storyboard?.instantiateViewControllerWithIdentifier(Constants.DetailTableViewVCIdentifier) as! DetailTableViewController
//        destination.movie = movie
//        navigationController?.pushViewController(destination, animated: true)
//    }
//    
//}
//
//extension DetailTableViewController: UpdateListViewDelegate {
//    
//    func updateListViewDidAddItemToList(identifier: String, listView: UpdateListView) {
//        guard let movieID = movie?.movieID else { return }
//        detailCoordinator.addToList(movieID, list: identifier)
//    }
//    
//    func updateListViewDidRemoveItemFromList(identifier: String, listView: UpdateListView) {
//        guard let movieID = movie?.movieID else { return }
//        detailCoordinator.removeFromList(movieID, list: identifier)
//    }
//    
//}
