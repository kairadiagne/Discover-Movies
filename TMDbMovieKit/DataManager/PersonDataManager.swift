//
//  PeopleDataManager.swift
//  Discover
//
//  Created by Kaira Diagne on 03-12-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public class PersonManager: DataManager<Person> {
    
    // MARK: - Properties
    
    let personID: Int
    
    // MARK: - Initialize
    
    public init(personID: Int) {
        self.personID = personID
        let configuration = PersonConfig(personID: personID)
        super.init(configuration: configuration , refreshTimeOut: 600)
    }
    
}


