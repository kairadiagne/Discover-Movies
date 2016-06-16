//
//  TMDbUserClient.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

class TMDbUserClient: TMDbAPIClient {
    
    // Gets information about the user
    
    func fetchUserInfo(completionHandler: (user: TMDbUser?, error: NSError?) -> Void) {
        guard let sessionID = sessionID else {
            completionHandler(user: nil, error: authorizationError)
            return
        }
        
        let paramaters: [String: AnyObject] = ["session_id": sessionID]
        
        let endpoint = "account"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: paramaters)).validate()
            .responseObject { (response: Response<TMDbUser, NSError>) in
                
                guard response.result.error == nil else {
                    completionHandler(user: nil, error: response.result.error)
                    return
                }
                
                if let user = response.result.value {
                    completionHandler(user: user, error: nil)
                    return
                }
        }
        
    }
    
}

