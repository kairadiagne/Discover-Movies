//
//  ProfileImageView.swift
//  Discover
//
//  Created by Kaira Diagne on 10-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class ProfileImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
    }
    
    private func setUp() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
        
}

