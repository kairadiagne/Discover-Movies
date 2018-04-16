//
//  MenuViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

protocol MenuViewControllerDelegate: class {
    func menu(viewController: UIViewController, didclickItemAtIndexPath indexPath: IndexPath)
    func menu(viewController: UIViewController, itemForRowAtIndexPath indexPath: IndexPath) -> MenuItem?
    func menu(viewController: UIViewController, numberOfItemsInSection: Int) -> Int
}

class MenuViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet var menuView: MenuView!
    
    weak var delegate: MenuViewControllerDelegate?
    
    private let userService: TMDbUserService
    
    private let sessionManager: TMDbSessionManager

    private var signedIn: Bool {
        return sessionManager.signInStatus == .signedin
    }
    
    init(sessionManager: TMDbSessionManager, userService: TMDbUserService = TMDbUserService()) {
        self.userService = userService
        self.sessionManager = sessionManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.tableView.register(MenuTableViewCell.nib, forCellReuseIdentifier: MenuTableViewCell.reuseId)
        
        menuView.tableView.dataSource = self
        menuView.tableView.delegate = self
        
        menuView.tableView.bounces = false
        
        userService.delegate = self
        
        menuView.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        menuView.tableView.reloadData()
        
        if signedIn {
            menuView.configure(withUser: sessionManager.user)
            userService.getUserInfo()
        } else {
            menuView.configure()
            menuView.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource 

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.menu(viewController: self, numberOfItemsInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseId) as! MenuTableViewCell
        
        guard let menuItem = delegate?.menu(viewController: self, itemForRowAtIndexPath: indexPath) else {
            return cell
        }
        
        let title = menuItem.title(signedIn: signedIn)
        let icon = menuItem.icon(signedIn: signedIn)
        let enable = menuItem.enable(signedIn: signedIn)
        
        cell.configure(title: title, image: icon, enable: enable)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.menu(viewController: self, didclickItemAtIndexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - TMDbUserServiceDelegate

extension MenuViewController: TMDbUserServiceDelegate {
    
    func user(service: TMDbUserService, didLoadUserInfo user: User) {
        menuView.configure(withUser: user)
        menuView.tableView.reloadData()
    }
    
    func user(service: TMDbUserService, didFailWithError error: APIError) {
        ErrorHandler.shared.handle(error: error)
    }
}
