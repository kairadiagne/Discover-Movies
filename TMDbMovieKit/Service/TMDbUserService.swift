//
//  TMDbUserService.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// TODO: - Almofire requets with completiohandler that returns on the main thread

class TMDbUserService {
    
    private var APIKey: String {
        return TMDbSessionInfoStore().APIKey
    }
    
    private var sessionID: String? {
        return TMDbSessionInfoStore().sessionID
    }
    
    // Gets the basic information for an account
    
    func fetchUserInfo(completionHandler: (user: TMDbUser?, error: NSError?) -> ()) {
        guard let sessionID = sessionID else { return completionHandler(user: nil, error: nil) } // Should return a authorization error
        
        Alamofire.request(TMDbSignInRouter.UserInfo(sessionID, APIKey: APIKey)).validate().responseObject { (response: Response<TMDbUser, NSError>) in
            guard response.result.error == nil else {
                completionHandler(user: nil, error: response.result.error!)
                return
            }
            
            if let user = response.result.value {
                completionHandler(user: user, error: nil)
            }
        }
    }
    
}



