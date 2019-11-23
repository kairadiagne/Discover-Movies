//
//  GenreViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

// Convert into a `UICollectionViewController` with a flow layout that has two three or one column based on the size of the window.
final class MovieListViewController: BaseViewController {

    // MARK: - Properties

    private lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: ColumnFlowLayout())
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh(control:)), for: .valueChanged)
        return refreshControl
    }()

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

    private func setupView() {
        view.embed(subView: collectionView)

        // Register cells
        collectionView.registerReusableCell(MovieBackdropCell.self)
        collectionView.registerReusableCell(NoDataCollectionViewCell.self)

        collectionView.delegate = self
        collectionView.dragDelegate = self
        collectionView.dataSource = dataSource
        collectionView.refreshControl = refreshControl
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        notificationToken = NotificationCenter.default.addObserver(forName: DataManagerUpdateEvent.dataManagerUpdateNotificationName, object: dataManager, queue: .main) { [weak self] notification in
            guard let self = self, let updateEvent = notification.userInfo?[DataManagerUpdateEvent.updateNotificationKey] as? DataManagerUpdateEvent else { return }
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
        collectionView.reloadData()
        dataManager.reloadIfNeeded()
    }
    
    // MARK: - Notifications
    
    private func handleUpdateEvent(_ updateEvent: DataManagerUpdateEvent) {
        switch updateEvent {
        case .didStartLoading:
            break
        case .didUpdate:
            dataSource.items = dataManager.allItems
            collectionView.reloadData()
        case .didFailWithError(let error):
            collectionView.reloadData()
            guard let error = error as? APIError else { return }
            ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
        }
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.item(atIndex: indexPath.row) else { return }
        showDetailViewController(for: movie, signedIn: signedIn)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension MovieListViewController: UICollectionViewDragDelegate {

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let selectedMovie = dataSource.item(atIndex: indexPath.row) else { return [] }

        let userActivity = NSUserActivity.detailActivity(for: selectedMovie)
        let itemProvider = NSItemProvider(object: userActivity)

        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = selectedMovie

        return [dragItem]
    }
}
