//
//  DateGenerator.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 11-06-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
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
