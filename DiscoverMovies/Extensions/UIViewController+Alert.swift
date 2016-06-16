//
//   UIViewController+Alert.swift
//  Discover
//
//  Created by Kaira Diagne on 11-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWithTitle(title: String, message: String, completionHandler: ((UIAlertAction) -> Void)? ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: .Default, handler: completionHandler)
        alertController.addAction(alertAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}


