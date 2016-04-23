//
//  CustomButton.swift
//  Discover
//
//  Created by Kaira Diagne on 20-02-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    // MARK: - Constants
    
    private struct Constants {
        static let Color = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        static let BackgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.0)
    }

    // MARK: - Initializerss
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor.clearColor()
        self.layer.borderColor = Constants.Color.CGColor
        self.backgroundColor = Constants.BackgroundColor
        self.tintColor = Constants.Color
    }
}
