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
    
    var personDetailView: PersonDetailView {
        return view as! PersonDetailView
    }
    
    fileprivate let personDataManager: PersonDataManager
    
    fileprivate let dataSource: MovieCollectionDataSource
    
    private let signedIn: Bool
    
    // MARK: - Initialize
    
    init(personID: Int, signedIn: Bool) {
        self.personDataManager = PersonDataManager(personID: personID)
        self.signedIn = signedIn
        self.dataSource = MovieCollectionDataSource(emptyMessage: NSLocalizedString("emptyMoviesMessage", comment: ""))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: MovieCollectionViewCell.nibName(), bundle: nil)
        personDetailView.moviesCollectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.defaultIdentfier())
        let emptyNib = UINib(nibName: NoDataCollectionViewCell.nibName(), bundle: nil)
        personDetailView.moviesCollectionView.register(emptyNib, forCellWithReuseIdentifier: NoDataCollectionViewCell.defaultIdentfier())
        
        personDetailView.moviesCollectionView.delegate = self
        personDetailView.moviesCollectionView.dataSource = dataSource
        
        personDataManager.failureDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(PersonDetailViewController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(PersonDetailViewController.dataManagerDidUpdate(notification:))
        personDataManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)
        
        personDataManager.reloadIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        personDataManager.remove(observer: self)
    }
    
    // MARK: - Notifications
    
    override func dataManagerDidUpdate(notification: Notification) {
        if let person = personDataManager.person {
            personDetailView.configure(with: person)
        }
    }
    
    // MARK: - DataManagerFailureDelegate
    
    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
        // TODO: - What to do when we had no internet connection and now connection is back because no pull to refresh
        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
    }

}

// MARK: - UICollectionViewDelegate

extension PersonDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // guard let movie =  else { return }
        // let detailViewController = DetailViewController(movie: movie, signedIn: true)
        // navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PersonDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return !dataSource.isEmpty ? CGSize(width: 78, height: 130): personDetailView.moviesCollectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
