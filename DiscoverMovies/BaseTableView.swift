//
//  BaseTableView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 06/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
    
    var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Create and configure message label
        let frame = CGRect(origin: .zero, size: bounds.size)
        messageLabel = UILabel(frame: frame)
        messageLabel.textAlignment = .Center
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .ByWordWrapping
        messageLabel.font = UIFont.Body()
        messageLabel.tintColor = UIColor.redColor()
        
        // Add message label to backgroundView
        backgroundView = messageLabel
        backgroundView?.hidden = true
        
        // Add empty UIView to the footer so that empty cells are not visible
        tableFooterView = UIView()
    }
    
    // MARK: - Behaviors
    
    func showMessage(message: String) {
        messageLabel.text = message
        backgroundView?.hidden = false
    }
    
    func hideMessage() {
        messageLabel.text = nil
        backgroundView?.hidden = true
    }
    
    func tableViewScrollToTop() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: false)
    }

}