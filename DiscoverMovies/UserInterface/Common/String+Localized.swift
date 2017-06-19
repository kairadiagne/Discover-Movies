//
//  String+Localized.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-06-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: self)
    }
    
    func localized(_ comment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
    
}
