//
//  PersonDetailViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class PersonDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    let personDataManager: PersonDataManager
    
    // MARK: - Initialize
    
    init(personID: Int) {
        self.personDataManager = PersonDataManager(personID: personID)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(PersonDetailViewController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(PersonDetailViewController.dataManagerDidUpdate(notification:))
        personDataManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)
        
        personDataManager.failureDelegate = self
        
        personDataManager.reloadIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        personDataManager.remove(observer: self)
    }
    
    // MARK: - Notifications
    
    override func dataManagerDidStartLoading(notification: Notification) {
    }
    
    override func dataManagerDidUpdate(notification: Notification) {
        print(personDataManager.person)
    }
    
    // MARK: - DataManagerFailureDelegate
    
    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
        print(error)
    }

}
