//
//  SignInBuilder.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

struct SignInViewControllerFactory {

    static func create(with container: DependencyContainer) -> SignInViewController {
        return SignInViewController(sessionManager: container.sessionManager, signInService: TMDbSignInService(), userService: TMDbUserService())
    }
}
