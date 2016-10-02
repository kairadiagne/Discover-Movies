
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

