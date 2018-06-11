//
//  TMDbSignInManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

// TODO: - Use SFAuthenticatioNSession in iOS 11 devices

/*
 TMDb authentication workflow:
 
 - Step 1: Create a new request token: This is a temporary token that is required to ask the user for permission to access their account.
 You can generate any number of request tokens but hey will expire after 60 minutes. As soon as a valid sessionID has been created the token
 will be destroyed.
 
 - Step 2: Ask the user for permission via the website:
 The next step is to take the token you got from step 1 and direct your use to the following URL:
 https://www.themoviedb.org/authenticate/REQUEST_TOKen
 The callback URK is also accessible via the Authentication-Callback header that gets returned.
 You can also pass in a redirect_param when making this call which will redirect the user once the authentication flow has been completed.
 
 - Step 3: Create a session ID: Assuming the reques token was authorized in step 2, you can nog go and request a session ID.
 The results of this query will return a session_id value. This is the value required in all of the write methods.
 
 */

public protocol TMDbSignInDelegate: class {
    func signIn(service: TMDbSignInService, didReceiveAuthorizationURL url: URL)
    func signIn(service: TMDbSignInService, didFailWithError error: APIError)
    func signInServiceDidSignIn(_ service: TMDbSignInService)
}

public class TMDbSignInService {
    
    // MARK: - Properties
    
    public weak var delegate: TMDbSignInDelegate?
    
    private var isLoading = false
    
    private let sessionInfoProvider: SessionInfoContaining
    
    private var token: RequestToken?
    
    // MARK: - Initialize
    
    public init() {
        self.sessionInfoProvider = SessionInfoService.shared
    }
    
    // MARK: - Sign In 
    
    public func requestToken() {
//        Alamofire.request(APIRouter.request(config: RequestTokenConfiguration(), queryParams: nil, bodyParams: nil))
//            .validate().responseObject { (response: DataResponse<RequestToken>) in
//
//                switch response.result {
//                case .success(let token):
//                    self.token = token
//
//                    let path: String = "\(TMDbAPI.AuthenticateURL)\(token.token)"
//
//                    if let url = URL(string: path) {
//                        self.delegate?.signIn(service: self, didReceiveAuthorizationURL: url)
//                    } else {
//                        self.delegate?.signIn(service: self, didFailWithError: .generic)
//                    }
//                case .failure(let error):
//                    if let error = error as? APIError {
//                        self.delegate?.signIn(service: self, didFailWithError: error)
//                    } else {
//                        self.delegate?.signIn(service: self, didFailWithError: .generic)
//                    }
//                }
//        }
    }
    
    public func requestSessionID() {
//        guard let token = token?.token else {
//            delegate?.signIn(service: self, didFailWithError: .generic)
//            return
//        }
//        
//        let paramaters: [String: AnyObject] = ["request_token": token as AnyObject]
//        
//        Alamofire.request(APIRouter.request(config: RequestSessionTokenConfiguration(), queryParams: paramaters, bodyParams: nil))
//            .validate().responseJSON { response in
//                
//                switch response.result {
//                case .success(let json):
//                    guard let resultDict = json as? [String: AnyObject] else { return }
//                    guard let sessionID = resultDict["session_id"] as? String else { return }
//                    
//                    self.sessionInfoProvider.saveSessionID(sessionID)
//                    self.delegate?.signInServiceDidSignIn(self)
//
//                case .failure(let error):
//                    let error = APIErrorHandler.categorize(error: error)
//                    self.delegate?.signIn(service: self, didFailWithError: error)
//                }
//        }
    }
}
