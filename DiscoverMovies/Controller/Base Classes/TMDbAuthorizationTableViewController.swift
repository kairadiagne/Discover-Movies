////
////  TMDbAuthorizationTableViewController.swift
////  
////
////  Created by Kaira Diagne on 20-04-16.
////
////
//
//import UIKit
//import TMDbMovieKit
//import SafariServices
//
//class TMDbAuthorizationTableViewController: DiscoverBaseTableViewController {
//    
//    private struct Storyboard {
//        static let SigninStoryBoardName = "Signin"
//        static let SigninVCIdentifier = "SignInViewController"
//    }
//    
////    private let signInService = TMDbSignInService(APIKey: Global.APIKey)
////    private let userInfoStore = TMDbUserInfoStore()
//    private var safariVC: SFSafariViewController!
//    
//    private var userIsInTheMiddleOfLogin: Bool {
//        set { NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "UserInTheMiddleOfLogin") }
//        get { return NSUserDefaults.standardUserDefaults().boolForKey("UserInTheMiddleOfLogin") }
//    }
//    
//    // MARK: - View Controller Life Cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        signInService.delegate = self
//    }
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        switch userInfoStore.userStatus {
//        case .Unknown where !userIsInTheMiddleOfLogin:
//            presentSignInView()
//        case .Signedin:
//            print("signed in")
//        case .PublicMode:
//            print("Public mode")
//        default:
//            return
//        }
//    }
//    
//    override func viewDidDisappear(animated: Bool) {
//        super.viewDidDisappear(animated)
//        switch userInfoStore.userStatus {
//        case .Unknown where userIsInTheMiddleOfLogin:
//            userIsInTheMiddleOfLogin = false
//        default:
//            return
//        }
//        
//    }
//    
//    func presentSignInView() {
//        let storyboard = UIStoryboard(name: Storyboard.SigninStoryBoardName, bundle: nil)
//        let signInVC = storyboard.instantiateViewControllerWithIdentifier(Storyboard.SigninVCIdentifier) as! SignInViewController
//        signInVC.delegate = self
//        presentViewController(signInVC, animated: true, completion: nil)
//    }
//    
//}
//
//extension TMDbAuthorizationTableViewController: SignInViewDelegate {
//    
//    func signInViewDidTapSignInButton() {
//        userIsInTheMiddleOfLogin = true
//        dismissViewControllerAnimated(false, completion: nil)
//        signInService.requestToken()
//    }
//    
//    func signInViewDidTapContinueWithoutSignInButton() {
//        userIsInTheMiddleOfLogin = false
//        signInService.activatePublicMode()
//        dismissViewControllerAnimated(true, completion: nil)
//    }
//
//}
//
//extension TMDbAuthorizationTableViewController: TMDbSignInServiceDelegate {
//    
//    func TMDbSignInServiceCouldNotObtainToken(error: NSError) {
//        userIsInTheMiddleOfLogin = false
//        detectInternetConnectionError(error)
//        presentSignInView()
//        
//    }
//    
//    func TMDbSignInServiceDidObtainToken(authorizeURL: NSURL?) {
//        guard let url = authorizeURL else { return }
//        safariVC = SFSafariViewController(URL: url)
//        safariVC.delegate = self
//        presentViewController(safariVC, animated: true, completion: nil)
//        
//    }
//    
//    func TMDbSignInServiceSignInDidComplete() {
//        userIsInTheMiddleOfLogin = false
//        signInService.fetchUserInfo()
//    }
//    
//    func TMDbSignInServiceSignInDidFail(error: NSError) {
//        userIsInTheMiddleOfLogin = false
//        detectInternetConnectionError(error)
//        presentSignInView()
//    }
//    
//}
//
//extension TMDbAuthorizationTableViewController: SFSafariViewControllerDelegate {
//    
//    func safariViewController(controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
//        if !didLoadSuccessfully {
//            userIsInTheMiddleOfLogin = false
//            controller.dismissViewControllerAnimated(true, completion: nil)
//        }
//    }
//    
//    func safariViewControllerDidFinish(controller: SFSafariViewController) {
//        signInService.requestSessionID()
//    }
//}
