//
//  PeopleDataManager.swift
//  Discover
//
//  Created by Kaira Diagne on 03-12-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class PersonDataManager: DataManager<Person> {
    
    // MARK: - Properties
    
    private let personID: Int
    
    public var person: Person? {
        return cachedData.data
    }
    
    // MARK: - Init
    
    public init(personID: Int) {
        self.personID = personID
        super.init(refreshTimeOut: 500)
    }

    // MARK: - Calls

    override func loadOnline() {
        let requestBuilder = RequestBuilder.person(personID: personID)
        makeRequest(builder: requestBuilder)
    }
}
