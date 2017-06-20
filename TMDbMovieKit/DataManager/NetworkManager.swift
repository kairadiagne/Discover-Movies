//
//  NetworkManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-06-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    // MARK: - Properties
    
    static let shared = NetworkManager()
    
    lazy var sessionManager: SessionManager = {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        return SessionManager(configuration: config)
    }()
    
}
