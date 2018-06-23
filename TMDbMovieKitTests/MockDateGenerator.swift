//
//  MockDateGenerator.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 11-06-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

@testable import TMDbMovieKit

class MockDateGenerator: DateGenerating {

    private var date = Date()

    func travel(by timeInterval: Double) {
        date = date.addingTimeInterval(timeInterval)
    }

    func getCurrentDate() -> Date {
        return date
    }
}
