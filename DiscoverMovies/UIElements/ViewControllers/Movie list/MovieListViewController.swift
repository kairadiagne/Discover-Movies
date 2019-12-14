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

    private let dataProvider: MovieListDataProvider

    private var dataSource: CollectionViewFetchedResultsDataSource<MovieListData>!

    private let signedIn: Bool
    
    // MARK: - Initialize
    
    init(dataProvider: MovieListDataProvider, titleString: String, signedIn: Bool) {
        self.dataProvider = dataProvider
        self.signedIn = signedIn
        super.init(nibName: nil, bundle: nil)
        self.title = titleString
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        dataProvider.reloadIfNeeded()
    }

    private func setupView() {
         view.embed(subView: collectionView)

         collectionView.registerReusableCell(MovieBackdropCell.self)

         collectionView.delegate = self
         collectionView.dataSource = dataSource
         collectionView.refreshControl = refreshControl
     }

    private func setupDataSource() {
        dataSource = CollectionViewFetchedResultsDataSource(collectionView: collectionView, fetchedResultsController: dataProvider.fetchedResultsController, cellProvider: { [weak self] indexPath -> UICollectionViewCell? in
            guard let self = self else { return nil }
            let object = self.dataSource.objectAtIndexPath(indexPath).movie
            let cell = self.collectionView.dequeueReusableCell(forIndexPath: indexPath) as MovieBackdropCell
            let viewModel = MovieBackDropCellViewModel(movie: object)
            cell.configure(with: viewModel)
            return cell
        })
    }
    
    // MARK: - Actions
    
    @objc private func refresh(control: UIRefreshControl) {
        dataProvider.reloadIfNeeded(forceOnline: true)
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

//extension MovieListViewController: UICollectionViewDragDelegate {

//    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
////        guard let selectedMovie = dataSource.item(atIndex: indexPath.row) else { return [] }
////
////        let userActivity = NSUserActivity.detailActivity(for: selectedMovie)
////        let itemProvider = NSItemProvider(object: userActivity)
////
////        let dragItem = UIDragItem(itemProvider: itemProvider)
////        dragItem.localObject = selectedMovie
////
////        return [dragItem]
//    }
//}

//        guard let movie = dataSource.item(atIndex: indexPath.row) else { return }
//        showDetailViewController(for: movie, signedIn: signedIn)
//        collectionView.deselectItem(at: indexPath, animated: true)

//
