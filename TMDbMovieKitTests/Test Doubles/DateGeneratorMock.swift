//
//  DateGeneratorMock.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 12/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

@testable import TMDbMovieKit

final class DateGeneratorMock: DateGenerating {

    // MARK: - Properties

    private var date: Date

    // MARK: - Initialize

    init(date: Date) {
        self.date = date
    }

    // MARK: - DateGenerating

    func getCurrentDate() -> Date {
        return date
    }

    func travel(by timeInterval: TimeInterval) {
        let newDate = self.date.addingTimeInterval(timeInterval)
        self.date = newDate
    }
}

