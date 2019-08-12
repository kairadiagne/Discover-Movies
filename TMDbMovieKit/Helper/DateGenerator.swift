//
//  DateGenerator.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 11/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

protocol DateGenerating {
    func getCurrentDate() -> Date
}

struct DateGenerator: DateGenerating {

    func getCurrentDate() -> Date {
        return Date()
    }
}
