//
//  PeopleDataManager.swift
//  Discover
//
//  Created by Kaira Diagne on 03-12-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public final class PersonDataManager: DataManager<TMDBPerson> {
    
    // MARK: - Properties
    
    let personID: Int
    
    public var person: TMDBPerson? {
        return cachedData.data
    }
    
    // MARK: - Initialize
    
    public init(personID: Int) {
        self.personID = personID
        super.init(request: ApiRequest.person(with: personID), refreshTimeOut: 600)
    }
}
