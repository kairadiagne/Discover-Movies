//
//  String+Localized.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-06-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation

extension String {
    
    var localizedString: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: self)
    }
    
    func localizedString(_ comment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
    
}
