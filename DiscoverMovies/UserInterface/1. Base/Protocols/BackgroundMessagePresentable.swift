//
//  BackgroundMessagePresentable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17/06/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

// MARK: Protocol BackgroundMessagePresentable

protocol BackgroundMessagePresentable: class {
    var messageLabel: UILabel? { get set }
    func setUpMessageLabel()
    func showMessage(_ message: String)
    func hideMessage()
}

// MARK: Default Implementations BackgroundMessagePresentable

extension BackgroundMessagePresentable where Self: UIView {
    
    func setUpMessageLabel() {
        let frame = CGRect(origin: .zero, size: bounds.size)
        messageLabel = UILabel(frame: frame)
        messageLabel?.textAlignment = .center
        messageLabel?.numberOfLines = 0
        messageLabel?.lineBreakMode = .byWordWrapping
        messageLabel?.font = UIFont.Body()
        messageLabel?.textColor = UIColor.white
        messageLabel?.sizeToFit()
    }
    
    func hideMessage() {
        messageLabel?.text = nil
    }
    

}

extension BackgroundMessagePresentable where Self: UITableView {
    
    func showMessage(_ message: String) {
        if messageLabel == nil {
            setUpMessageLabel()
            backgroundView = messageLabel
        }
        
        messageLabel?.text = message
    }
    
}

extension BackgroundMessagePresentable where Self: UICollectionView {
    
    func showMessage(_ message: String) {
        if messageLabel == nil {
            setUpMessageLabel()
            backgroundView = messageLabel
        }
        
        messageLabel?.text = message
    }
    
}
