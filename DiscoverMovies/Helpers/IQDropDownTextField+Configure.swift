//
//  IQDropDownTextField+Configure.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import IQDropDownTextField

extension IQDropDownTextField {
    
    func configure(items: [String], toolbar: UIToolbar, delegate: IQDropDownTextFieldDelegate) {
        isOptionalDropDown = true
        inputAccessoryView = toolbar
        itemList = items
        self.delegate = delegate
    }
    
}


