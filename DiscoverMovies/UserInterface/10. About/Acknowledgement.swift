//
//  Acknowledgement.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 30-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import TMDbMovieKit

struct Acknowledgement {
    
    // MARK: - Properties
    
    let title: String
    var license: String?
    let footer: String
    
    // MARK: - Initialize
    
    init?(dictionary dict: [String: AnyObject]) {
        guard let title = dict["Title"] as? String, let footer = dict["FooterText"] as? String else {
            return nil
        }
        
        self.title = title
        self.license = dict["License"] as? String
        self.footer = footer
    }
    
    func dictionaryRepresentation() -> [String: AnyObject] {
        return [:]
    }
    
}
