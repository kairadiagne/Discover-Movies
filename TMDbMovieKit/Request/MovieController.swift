//
//  MovieController.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 17-04-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

class MovieController {

    // MARK: - Properties

    private let client: APIClient

    private let persistentContainer: NSPersistentContainer

    // MARK: - Initialize

    init(client: APIClient, persistentContainer: NSPersistentContainer) {
        self.client = client
        self.persistentContainer = persistentContainer
    }

    // MARK: - Load

    public func reloadIfNeeded(forceOnline: Bool = false, paramaters: [String: Any]? = nil) {
        // guard cachedData.needsRefresh || forceOnline || params != nil else { return }

    }

    func loadOnline() {

        client.get(path: "movie/popular", paramaters: nil, body: nil) { object in
            print(object)
            persistentContainer.performBackgroundTask { context in
                // Check if already exist else overwrite

            }
        }
    }

    // MARK: - Results

    func popularMovies() -> NSFetchedResultsController {

    }
}

// Default logic is reload if needed
// Extra logic is things like favoriting etc


//public func reloadIfNeeded(forceOnline: Bool = false, paramaters params: [String: AnyObject]? = nil) {
//    guard cachedData.needsRefresh || forceOnline || params != nil else { return }
//    cachedParams = params ?? [:]
//    loadOnline(paramaters: cachedParams)
//}
//
//// MARK: - Networking
//
//func loadOnline(paramaters params: [String: AnyObject], page: Int = 1) {
//    startLoading()
//
//    var params = params
//    params["page"] = page as AnyObject?
//    cachedParams = params
//
//    NetworkManager.shared.sessionManager.request(APIRouter.request(config: requestConfig, queryParams: params, bodyParams: nil))
//        .validate().responseObject { (response: DataResponse<ModelType>) in
//
//            self.stopLoading()
//
//            switch response.result {
//            case .success(let data):
//                self.handle(data: data)
//                self.persistDataIfNeeded()
//            case .failure(let error):
//                if let error = error as? APIError {
//                    self.failureDelegate?.dataManager(self, didFailWithError: error)
//                } else {
//                    self.failureDelegate?.dataManager(self, didFailWithError: .generic)
//                }
//            }
//    }
//}
