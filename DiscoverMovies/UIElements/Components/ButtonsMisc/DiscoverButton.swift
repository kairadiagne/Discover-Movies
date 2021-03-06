//
//  DiscoverButton.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 30-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

final class DiscoverButton: UIButton {
    
    // MARK: - Initialize 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .clear
        
        setTitleColor(.buttonColor(), for: .normal)
        setTitleColor(.backgroundColor(), for: .highlighted)
        
        setBackground(color: UIColor.clear, forState: .normal)
        setBackground(color: .buttonColor(), forState: .highlighted)
        
        layer.borderColor = UIColor.buttonColor().cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
