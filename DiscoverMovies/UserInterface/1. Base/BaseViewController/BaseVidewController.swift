////
////  BaseViewController.swift
////  DiscoverMovies
////
////  Created by Kaira Diagne on 13/05/16.
////  Copyright © 2016 Kaira Diagne. All rights reserved.
////
//
//import UIKit
//import TMDbMovieKit
//import MBProgressHUD
//
//class BaseViewCondddddddtroller: UIViewController, BannerPresentable, ProgressHUDPresentable, DataManagerFailureDelegate {
//    
//    // MARK: Types
//    
//    fileprivate struct Constants {
//        static let UserInfoKey = "error"
//    }
//    
//    // MARK: Properties
//    
//    var progressHUD: MBProgressHUD?
//    
//    var shouldShowSignInViewController: Bool {
//        return TMDbSessionManager.shared.signInStatus == .unkown ? true : false
//    }
//    
//    fileprivate var signedIn: Bool {
//        return TMDbSessionManager.shared.signInStatus == .signedin ? true: false
//    }
//    
//    // MARK: LifeCycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        progressHUD = MBProgressHUD.hudWithSize(CGSize(width: 40, height: 40), forFrame: view.bounds)
//        progressHUD?.isUserInteractionEnabled = false
//        view.addSubview(progressHUD!)
//    }
//
//    // MARK: Notifications
//    
//    func dataDidStartLoadingNotification(_ notification: Notification) {
//        showProgressHUD()
//    }
//    
//    func dataDidLoadTopNotification(_ notification: Notification) {
//        hideProgressHUD()
//    }
//    
//    // MARK: Error Handeling
//    
//    func listDataManager(_ manager: AnyObject, didFailWithError error: APIError) {
//        handleError(error)
//    }
//    
//    func handleError(_ error: APIError) {
//        switch error {
//        case .generic:
//            presentAlertGenericError()
//        case .noInternetConnection:
//            presentBannerOnInternetError()
//        case .unAuthorized where TMDbSessionManager.shared.signInStatus == .signedin:
//            presentAlertOnAuthorizationError()
//        case .unAuthorized where TMDbSessionManager.shared.signInStatus == .unkown:
//            presentAlertOnAuthorizationError()
//        case .unAuthorized where TMDbSessionManager.shared.signInStatus == .publicMode:
//            return
//        default:
//            return
//        }
//    }
//    
//    func presentBannerOnInternetError() {
//        let title = NSLocalizedString("noConnectionTitle", comment: "Title of no internet connection banner")
//        let message = NSLocalizedString("noConnectionMessage", comment: "Message of no internet connection bannner")
//        //        showBanner(title, message: message, color: UIColor.flatOrangeColor())
//    }
//    
//    func presentAlertOnAuthorizationError() {
//        let title = NSLocalizedString("authorizationErrorTitle", comment: "Title of authorization error alert")
//        let message = NSLocalizedString("authorizationErrorMessage", comment: "Message of authorization error alert")
//        
//        let completionHandler = {
//            TMDbSessionManager.shared.signOut()
//            
//            if let menuViewController = (UIApplication.shared.delegate as? AppDelegate)?.menuViewController {
//                menuViewController.signOut()
//            }
//        }
//    
//        presentAlertWithTitle(title, message: message, completionhandler: completionHandler)
//    }
//    
//    func presentAlertGenericError() {
//        let title = NSLocalizedString("genericErrorTitle", comment: "Title of generic error alert")
//        let message = NSLocalizedString("genericErrorMessage", comment: "Message of generic error alert")
//        presentAlertWithTitle(title, message: message, completionhandler: nil)
//    }
//    
//    fileprivate func presentAlertWithTitle(_ title: String, message: String, completionhandler: (() -> Void)?) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        
//        let dismiss = UIAlertAction(title: "dismiss", style: .default) { action  in
//            completionhandler?()
//        }
//        
//        alertController.addAction(dismiss)
//        
//        present(alertController, animated: true, completion: nil)
//    }
//    
//    // MARK: Navigation
//    
//    func showSignInViewController() {
//        let signInViewController = SignInViewController()
//        present(signInViewController, animated: true, completion: nil)
//    }
//    
//    // MARK: - DataManagerFailureDelegate
//    
//    func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
//        
//    }
//
//}
