//
//  CoordinatorDelegate.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import TMDbMovieKit

protocol ItemCoordinatorDelegate: class {
    func coordinatorDidUpdateItems(page: Int?)
    func coordinatorDidReceiveError(error: NSError)
}
