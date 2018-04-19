//
//  AppDelegate.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private(set) var appCoordinator: AppCoordinator!
    
    // Testing
    private let controller = MovieListController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .backgroundColor()
        appCoordinator = AppCoordinator(window: window!)
        
        window?.makeKeyAndVisible()
        
        appCoordinator.start()
        
        Theme.apply()
        
        // Testing
        
        controller.delegate = self
        controller.reloadIfNeeded()

        return true
    }
}

extension AppDelegate: ListControllerDelegate {
    
    func listControllerDidStartLoading<T: Object>(_ controller: ListController<T>) {
        print("DidStartLoading")
    }
    
    func listControllerDidFinishInitialLoad<T: Object>(_ controller: ListController<T>) {
        print("InitialLoad")
    }
    
    func listControllerWillChangeContent<T: Object>(_ controller: ListController<T>) { // Remove ?
        print("WillChange")
    }
    
    func listControlleUpdate<T: Object>(_ controller: ListController<T>, deletions: [Int], insertions: [Int], modifications: [Int]) {
        print("Update")
    }
    
    func listControllerDidChangeContent<T: Object>(_ controller: ListController<T>) { // Remove ?
        print("DidChange")
    }
    
    func listController<T: Object>(_ controller: ListController<T>, didFailWithError: Error) {
        print("didFail")
    }
}
