//
//  MenuViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class MenuViewController: ListViewController {
    
    private let signInManager = TMDbSignInManager()
    
    private let dataProvider = MenuDataSource()
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.dataSource = dataProvider
//        tableView.delegate = self
    }
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check the signinstatus and act accordingly
            // Update the menu
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animate things
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - UITableViewDelegate 
    
    
    
    
    // MARK: - Navigation
    
    
 
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        switch indexPath.row {
//
//        }
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        switch indexPath.row {
        case 0:
            return nil
        default:
            return indexPath
        }
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.row {
        case 0:
            return false
        default:
            return true
        }
    }
    
}
    // View Related code
    
//    private func updateMenu(authorized: Bool, user: TMDbUser?) {
//        userNameLabel.text = user?.name ?? "Guest"
//        loginOutLabel.text = authorized ? "Sign Out" : "Sign in"
//        favoriteCell.userInteractionEnabled = authorized
//        favoriteLabel.enabled = authorized
//        watchListCell.userInteractionEnabled = authorized
//        watchListLabel.enabled = authorized
//        setProfileImage(user?.gravatarURI)
//    }
    
//    private func setProfileImage(gravatarURI: String?) {
        //        if let gravatarURI = gravatarURI {
        //            let url = TMDbImageRouter.ProfileSmall(path: gravatarURI).url
        //            print(url)
        //            profileImageview.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderProfileImage())
        //        } else {
        //            profileImageview.image = nil
        //        }
        //    }

//}

//
//    @IBOutlet weak var favoriteCell: UITableViewCell!
//    @IBOutlet weak var favoriteLabel: UILabel!
//    @IBOutlet weak var watchListCell: UITableViewCell!
//    @IBOutlet weak var watchListLabel: UILabel!
//    @IBOutlet weak var userNameLabel: UILabel!
//    @IBOutlet weak var loginOutLabel: UILabel!
//    @IBOutlet weak var profileImageview: ProfileImageView!
//
///
//        
//        userNameLabel.textColor = UIColor.flatSkyBlueColor()
//    }
//
//
//
//
//
//
//
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return .LightContent
//    }
//
//
//
//    // MARK: - Navigation
//
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == Storyboard.ToggleSignInSegueIdentifier {
//            userInfoStore.deactivatePublicMode()
//            userInfoStore.signOut()
//        }
//    }
//
//}
//

