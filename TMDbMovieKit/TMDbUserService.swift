//
//  TMDbUserServicre.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 18-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TMDbUserService {
    
    init() { }
    
    func fetchUserInfo(sessionID: String, completionHandler: Result<TMDbUser, NSError> -> ()) {
        Alamofire.request(TMDbSignInRouter.UserInfo(sessionID)).validate().responseObject { (response: Response<TMDbUser, NSError>) in
            completionHandler(response.result)
        }
    }

}