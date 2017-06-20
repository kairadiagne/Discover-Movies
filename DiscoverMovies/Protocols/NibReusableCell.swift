//
//  NibReusableCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-06-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

protocol ReusableCell {
    static var reuseId: String {get}
}

protocol NibLoadable {
    static var nibName: String {get}
    static var nib: UINib  {get}
}

typealias NibReusabelCell = ReusableCell & NibLoadable

/// Default to the **`String` value of the Class name** for both reuseId and nibName for ease of implementation
extension ReusableCell {
    
    static var reuseId : String {
        return String(describing: self)
    }
    
}

extension NibLoadable where Self : NSObject {
    
    static var nibName : String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName: self.nibName, bundle: Bundle(for: self))
    }
    
    static func loadFromNib(withOwner owner: Any? = nil) -> Self? {
        // top-level objects in nib file
        let nibObjects = self.nib.instantiate(withOwner: owner, options: nil)
        
        // find Self match
        for obj in nibObjects {
            if let obj = obj as? Self {
                return obj
            }
        }
        
        return nil
    }
    
}
