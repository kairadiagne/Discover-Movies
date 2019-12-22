//
//  TopListViewControllerBuilder.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

struct TopListViewControllerFactory {

    static func create(with container: DependencyContainer) -> TopListViewController {
        return TopListViewController()
    }
}
