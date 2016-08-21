//
//  ProfileImageView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 21-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class ProfileImageView: UIView {

    // MARK: Properties
    
    let imageView = UIImageView()
    
    
    // MARK: Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.clearColor()
        self.layer.cornerRadius = self.frame.size.width / 2

        self.imageView.contentMode = .ScaleAspectFill
        self.imageView.frame = self.bounds
        self.imageView.layer.borderWidth = 2
        self.imageView.layer.backgroundColor = UIColor.clearColor().CGColor
        self.imageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.imageView.layer.cornerRadius = imageView.frame.size.width / 2
        self.imageView.layer.masksToBounds = true
        
        self.addSubview(imageView)
    }

}
