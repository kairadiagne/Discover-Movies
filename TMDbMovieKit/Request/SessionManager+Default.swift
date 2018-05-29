//
//  SessionManager.default.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 27-05-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

let defaultManager: SessionManager = {
    let config = URLSessionConfiguration.default
    config.urlCache = nil
    return SessionManager(configuration: config)
}()
