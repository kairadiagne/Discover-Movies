//
//  MenuViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

private struct MenuItem {
    var image: String
    var text: String
}

class MenuViewController: UIViewController {
    
    private struct Constants {
        static let Identifier = "MenuCell"
    }
    
    private let signInManager = TMDbSignInManager()
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Check the signinstatus and act accordingly
            // Update the menu
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - Navigation
    
    func signout() {
        
    }
    
    func showFavoritesViewControlelr() {
        
    }
    
    func showWatchListViewController() {
        
    }
    
    func showDiscoverViewController() {
        // Create tabbar controller
        // Create nabar controller 
        // 
    }

}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.Identifier) as! MenuTableViewCell
        switch indexPath.row {
        case 0:
            cell.configureWithItem("Discover movies", imageName: "Discover")
        case 1:
            cell.configureWithItem("Movies I want to watch", imageName: "WatchList")
        case 2:
            cell.configureWithItem("My favorite movies", imageName: "Favorite")
        case 3:
            cell.configureWithItem("Signout", imageName: "Logout")
        default:
            fatalError()
        }
        return cell
    }

}
    




  
    
//    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//    {
//    return 6;
//    }
//    
//    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil)
//    {
//    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    NSString *text = nil;
//    switch ( indexPath.row )
//    {
//    case 0: text = @"heart.png"; break;
//    case 1: text = @"skull.png"; break;
//    case 2: text = @"gift.png"; break;
//    case 3: text = @"airplane.png"; break;
//    case 4: text = @"star.png"; break;
//    case 5: text = @" ...  More"; break;
//    }
//    
//    cell.imageView.image = [UIImage imageNamed:text];
//    cell.imageView.frame = CGRectMake(0,0,44,44);
//    cell.textLabel.text = text;
//    cell.textLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
//    return cell;
//    }
//    
//    
//    - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//    cell.backgroundColor = self.tableView.backgroundColor;
//    
//    }
//    
//    #pragma mark - Table view delegate
//    
//    
//    
//    
//    
//    - (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//    return indexPath;
//    }
//    
//    
//    
//    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//    SWRevealViewController *revealController = self.revealViewController;
//    
//    NSInteger row = indexPath.row;
//    
//    if ( row == _previouslySelectedRow )
//    {
//    [revealController revealToggleAnimated:YES];
//    return;
//    }
//    
//    _previouslySelectedRow = row;
//    
//    NSString *text = nil;
//    switch ( row )
//    {
//    case 0: text = @"bg_flowers.jpg"; break;
//    case 1: text = @"bg_blocks.jpg"; break;
//    case 2: text = @"bg_grass.jpg"; break;
//    case 3: text = @"Hello America!"; break;
//    case 4: text = @"Best Wishes!"; break;
//    }
//    
//    UIViewController *frontController = nil;
//    switch ( row )
//    {
//    case 0:
//    case 1:
//    case 2:
//    {
//    FrontViewControllerImage *imageController = [[FrontViewControllerImage alloc] init];
//    imageController.image = [UIImage imageNamed:text];
//    frontController = imageController;
//    break;
//    }
//    
//    case 3:
//    case 4:
//    {
//    FrontViewControllerLabel *labelController = [[FrontViewControllerLabel alloc] init];
//    labelController.text = text;
//    frontController = labelController;
//    break;
//    }
//    
//    case 5:
//    {
//    RearTableViewController *rearViewController = [[RearTableViewController alloc] init];
//    FrontViewControllerImage *frontViewController = [[FrontViewControllerImage alloc] init];
//    [frontViewController setImage:[UIImage imageNamed:@"bg_flowers.jpg"]];
//    
//    SWRevealViewController *childRevealController =
//    [[SWRevealViewController alloc] initWithRearViewController:rearViewController frontViewController:frontViewController];
//    
//    #define NoRevealOverdraw true
//    #if NoRevealOverdraw
//    childRevealController.rearViewRevealWidth = 60;
//    childRevealController.rearViewRevealOverdraw = 120;
//    childRevealController.bounceBackOnOverdraw = NO;
//    childRevealController.stableDragOnOverdraw = YES;
//    #else
//    childRevealController.rearViewRevealWidth = 200;
//    #endif
//    childRevealController.rearViewRevealDisplacement = 0;
//    
//    [childRevealController setFrontViewPosition:FrontViewPositionRight animated:NO];
//    frontController = childRevealController;
//    break;
//    }
//    }
//    
//    if ( row != 5 )
//    {
//    [revealController setFrontViewController:frontController animated:YES];    //sf
//    [revealController setFrontViewPosition:FrontViewPositionRight animated:YES];
//    }
//    else
//    {
//    [revealController setFrontViewController:frontController animated:YES];    //sf
//    [revealController setFrontViewPosition:FrontViewPositionRightMost animated:YES];
//    }
//    }
//    
//    @end
//
//    
// 
//}


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



