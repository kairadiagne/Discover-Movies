//
//  GenreViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

final class MovieListViewController: UICollectionViewController {

    // MARK: Properties

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh(control:)), for: .valueChanged)
        return refreshControl
    }()

    private let dataProvider: MovieListDataProvider
    private var dataSource: CollectionViewFetchedResultsDataSource<MovieListData>!
    
    // MARK: Initialize
    
    init(dataProvider: MovieListDataProvider, titleString: String, signedIn: Bool) {
        self.dataProvider = dataProvider
        super.init(collectionViewLayout: ColumnFlowLayout())
        self.title = titleString
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle

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
        collectionView.registerReusableCell(MovieBackdropCell.self)
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.refreshControl = refreshControl
        collectionView.backgroundColor = UIColor.secondarySystemBackground
    }

    private func setupDataSource() {
        dataSource = CollectionViewFetchedResultsDataSource(collectionView: collectionView, fetchedResultsController: dataProvider.fetchedResultsController(), cellProvider: { [weak self] indexPath -> UICollectionViewCell? in
            guard let self = self else { return nil }
            
            let object = self.dataSource.objectAtIndexPath(indexPath).movie
            let cell = self.collectionView.dequeueReusableCell(forIndexPath: indexPath) as MovieBackdropCell
            let viewModel = MovieBackDropCellViewModel(movie: object)
            cell.configure(with: viewModel)
            return cell
        })
    }
    
    private func loadEmptyStateIfNeeded() {
        // Load empty state
        // Enable or disable refresh control
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = dataSource.objectAtIndexPath(indexPath).movie
        let movieDetailViewController = MovieDetailViewController(movieObjectID: movie.objectID, signedIn: false)
        navigationController?.delegate = movieDetailViewController
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard dataSource.itemCount - 10 == indexPath.row else { return }
        dataProvider.loadMore()
    }
    
    // MARK: - Actions
    
    @objc private func refresh(control: UIRefreshControl) {
        dataProvider.reloadIfNeeded(forceOnline: true) { [weak self] _ in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
        }
    }
}
