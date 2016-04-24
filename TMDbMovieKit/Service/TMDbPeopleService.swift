//
//  TMDbPeopleService.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public enum TMDbPersonList: String {
    case Popular = "popular"
    case Latest = "latest"
}

// Completionhandlers

public class TMDbPeoplService {
    
    private let APIKey: String
    
    public init(APIKey key: String) {
        self.APIKey = key
    }
    
    // TODO: -  Write method that gets the list of popular people on The Movie Databse. This list refreshes every day.
    
    // TOO: - Write method that fetches information about a person by its ID
    
    // TODO: - Search for people by name: APIKey, Query string, page
    
}
    


