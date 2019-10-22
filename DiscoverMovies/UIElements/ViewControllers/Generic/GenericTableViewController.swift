//
//  GenreViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class GenericTableViewController: BaseViewController {
    
    // MARK: - Types
    
    private struct Constants {
        static let CellHeight: CGFloat = 250
    }
    
    // MARK: - Properties
    
    var genericView: GenericTableView {
        // swiftlint:disable force_cast
        return view as! GenericTableView
    }

    private let dataManager: ListDataManager<Movie>
    
    private let dataSource = MovieListDataSource()

    private var notificationToken: NSObjectProtocol?
    
    private let signedIn: Bool
    
    // MARK: - Initialize
    
    init(dataManager: ListDataManager<Movie>, titleString: String, signedIn: Bool) {
        self.dataManager = dataManager
        self.signedIn = signedIn
        super.init(nibName: nil, bundle: nil)
        self.title = titleString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = GenericTableView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        genericView.tableView.register(DiscoverListCell.nib, forCellReuseIdentifier: DiscoverListCell.reuseId)
        genericView.tableView.register(NoDataCell.nib, forCellReuseIdentifier: NoDataCell.reuseId)
        genericView.tableView.delegate = self
        genericView.tableView.dragDelegate = self
        genericView.tableView.dataSource = dataSource
        
        genericView.refreshControl.addTarget(self, action: #selector(GenericTableViewController.refresh(control:)), for: .valueChanged)

        notificationToken = NotificationCenter.default.addObserver(forName: DataManagerUpdateEvent.dataManagerUpdateNotificationName, object: nil, queue: .main) { [weak self] notification in
            guard let self = self, let updateEvent = notification.object as? DataManagerUpdateEvent else { return }
            self.handleUpdateEvent(updateEvent)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadData()
    }
    
    // MARK: - Actions
    
    @objc private func refresh(control: UIRefreshControl) {
        dataManager.reloadIfNeeded(forceOnline: true)
    }
    
    private func loadData() {
        dataSource.items = dataManager.allItems
        genericView.tableView.reloadData()
        
        dataManager.reloadIfNeeded()
    }
    
    // MARK: - Notifications
    
    private func handleUpdateEvent(_ updateEvent: DataManagerUpdateEvent) {
        switch updateEvent {
        case .didStartLoading:
            genericView.set(state: .loading)
        case .didUpdate:
            genericView.set(state: .idle)
            dataSource.items = dataManager.allItems
            genericView.tableView.reloadData()
        case .didFailWithError(let error):
            genericView.set(state: .idle)
            genericView.tableView.reloadData()
            guard let error = error as? APIError else { return }
            ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
        }
    }
}

// MARK: - UITableViewDelegate

extension GenericTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return !dataSource.isEmpty ? Constants.CellHeight : tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = dataSource.item(atIndex: indexPath.row) else { return }
        showDetailViewController(for: movie, signedIn: signedIn)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if genericView.state == .loading && dataSource.isEmpty {
            cell.isHidden = true
        } else if dataSource.itemCount - 10 == indexPath.row {
//            dataManager.loadMore()
        }
    }
}

extension GenericTableViewController: UITableViewDragDelegate {

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let selectedMovie = dataSource.item(atIndex: indexPath.row) else { return [] }

        let userActivity = selectedMovie.openMovieDetailUseractivity
        let itemProvider = NSItemProvider(object: userActivity)

        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = selectedMovie

        return [dragItem]
    }
}
