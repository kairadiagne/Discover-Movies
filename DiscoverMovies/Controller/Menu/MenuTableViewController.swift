//
//  MenuViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage
import ChameleonFramework

class MenuTableViewController: UITableViewController {
    
    private struct Storyboard {
        static let ToggleSignInSegueIdentifier = "SignIn/SignOut"
    }
    
    @IBOutlet weak var favoriteCell: UITableViewCell!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var watchListCell: UITableViewCell!
    @IBOutlet weak var watchListLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var loginOutLabel: UILabel!
    @IBOutlet weak var profileImageview: ProfileImageView!
    
    private let userInfoStore = TMDbUserInfoStore()
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.tableFooterView = UIView(frame: CGRectZero)
        userNameLabel.textColor = UIColor.flatSkyBlueColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let userIsSignedIn = userInfoStore.userStatus == .Signedin
        updateMenu(userIsSignedIn , user: userInfoStore.user)
    }
    
    private func updateMenu(authorized: Bool, user: TMDbUser?) {
        userNameLabel.text = user?.name ?? "Guest"
        loginOutLabel.text = authorized ? "Sign Out" : "Sign in"
        favoriteCell.userInteractionEnabled = authorized
        favoriteLabel.enabled = authorized
        watchListCell.userInteractionEnabled = authorized
        watchListLabel.enabled = authorized
        setProfileImage(user?.gravatarURI)
    }
    
    private func setProfileImage(gravatarURI: String?) {
        if let gravatarURI = gravatarURI {
            let url = TMDbImageRouter.ProfileSmall(path: gravatarURI).url
            print(url)
            profileImageview.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderProfileImage())
        } else {
            profileImageview.image = nil
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        switch indexPath.row {
        case 0: return nil
        default: return indexPath
        }
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.row {
        case 0: return false
        default: return true
        }
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.ToggleSignInSegueIdentifier {
            userInfoStore.deactivatePublicMode()
            userInfoStore.signOut()
        }
    }

}

