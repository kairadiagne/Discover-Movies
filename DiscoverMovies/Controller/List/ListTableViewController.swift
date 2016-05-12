////
////  ListTableViewController.swift
////  DiscoverMovies
////
////  Created by Kaira Diagne on 20-04-16.
////  Copyright © 2016 Kaira Diagne. All rights reserved.
////
//
//import UIKit
//import TMDbMovieKit
//
//class ListTableViewController: DiscoverBaseTableViewController, RevealMenuButtonShowable, BackgroundMessagePresentable{
//    
//    private struct Storyboard {
//        static let ListCellIdentifier = "ListTableViewCell"
//        static let ListCellNibName = "ListTableViewCell"
//        static let ShowDetailSegueIdentifier = "ShowDetail"
//        static let RootTabBarVCIdentifier = "Root"
//    }
//    
//    var identifier: String { return "" }
//    private let listCoordinator = ListCoordinator()
//    
//    // MARK: - View Controller Life Cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        listCoordinator.delegate = self
//        listCoordinator.identifier = identifier
//        
//        configureMenuButton()
//        configureRefreshControl()
//        
//        // Setup the tableview
//        let nib = UINib(nibName: Storyboard.ListCellNibName , bundle: NSBundle.mainBundle())
//        tableView.registerNib(nib, forCellReuseIdentifier: Storyboard.ListCellIdentifier)
//        tableView.estimatedRowHeight = 210
//        tableView.rowHeight = UITableViewAutomaticDimension
//        configureViewWithBackgroundMessage("You have not added any movies to this list yet")
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        showProgressHUD()
//        listCoordinator.refresh()
//    }
//    
//    // MARK: - UITableViewDataSource
//    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listCoordinator.items.count
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.ListCellIdentifier, forIndexPath: indexPath) as! ListTableViewCell
//        let movie = listCoordinator.items[indexPath.row]
//        let imageURL = movie.backDropPath != nil ? TMDbImageRouter.PosterSmall(path: movie.posterPath!).url: nil
//        cell.configure(movie, imageURL: imageURL)
//        return cell
//    }
//    
//    // MARK: - UITableViewDelegate
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        guard let cell = tableView.cellForRowAtIndexPath(indexPath) else { return }
//        performSegueWithIdentifier(Storyboard.ShowDetailSegueIdentifier, sender: cell)
//    }
//    
//    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        listCoordinator.fetchNextPageIfNeeded(indexPath.row)
//    }
//    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            let movie = listCoordinator.items[indexPath.row]
//            listCoordinator.removeMovie(movie,fromList: identifier)
//        }
//    }
//    
//    // MARK: - ItemCoordinatorDelegate
//    
//    override func coordinatorDidUpdateItems(page: Int?) {
//        super.coordinatorDidUpdateItems(page)
//        stopRefreshing()
//    }
// 
//    override func coordinatorDidReceiveError(error: NSError) {
//        super.coordinatorDidReceiveError(error)
//        handleAuthorizationError()
//    }
//
//    // MARK: - Navigation
//
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == Storyboard.ShowDetailSegueIdentifier {
//            if let destination = segue.destinationViewController as? DetailTableViewController {
//                if let cell = sender as? UITableViewCell {
//                    if let index = tableView.indexPathForCell(cell) {
//                        destination.movie = listCoordinator.items[index.row]
//                    }
//                }
//            }
//        }
//    }
//    
//
//}
//
//// MARK: - Pull To Refresh
//
//extension ListTableViewController: PullToRefreshable {
//    
//    func refresh(sender: AnyObject) {
//        listCoordinator.refresh()
//    }
//    
//    func addTargetToRefreshControl() {
//        let selector = #selector(ListTableViewController.refresh(_:))
//        refreshControl?.addTarget(self, action: selector, forControlEvents: .ValueChanged)
//    }
//    
//}
//
//// MARK: AuthorizationHandlerProtocol
//
//extension ListTableViewController: AuthorizationErrorHandlerProtocol {
//    
//    func handleAuthorizationError() {
//        let title = "Not signed in"
//        let message = "To view this list it is required to sign in with your TMDb account"
//        showAlertWithTitle(title, message: message) { _ in
//            TMDbUserInfoStore().signOut()
//            guard let rootTabBarVC = self.storyboard?.instantiateViewControllerWithIdentifier(Storyboard.RootTabBarVCIdentifier) else { return }
//            self.revealViewController().pushFrontViewController(rootTabBarVC, animated: true)
//        }
//    }
//    
//}
