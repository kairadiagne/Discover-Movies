//
//  BaseTestCase.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 12/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Alamofire
import CoreData
import Mocker
import XCTest
@testable import TMDbMovieKit

class BaseTestCase: XCTestCase {

    private(set) var session: Session!
    private(set) var persistentContainer: MovieKitPersistentContainer!

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private(set) var readOnlyAPIKey: String!

    override func setUp() {
        super.setUp()

        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        session = Session(configuration: configuration)

        readOnlyAPIKey = UUID().uuidString
        DiscoverMoviesKit.configure(apiReadOnlyAccessToken: readOnlyAPIKey)

        MovieKitPersistentContainer.createInMemoryContainer { result in
            XCTAssertNil(result.error)
            self.persistentContainer = result.value
        }
    }

    override func tearDown() {
        session = nil
        persistentContainer = nil
        
        super.tearDown()
    }
}
