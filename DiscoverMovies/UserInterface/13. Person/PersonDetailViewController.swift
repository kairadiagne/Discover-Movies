//
//  PersonDetailViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SafariServices

class PersonDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    var personDetailView: PersonDetailView {
        // swiftlint:disable force_cast
        return view as! PersonDetailView
    }
    
    private let person: PersonRepresentable
    
    private let personDataManager: PersonDataManager
    
    private let dataSource: MovieCollectionDataSource
    
    private var safariVC: SFSafariViewController?
    
    private var biographyExpanded = false
    
    private let signedIn: Bool
    
    // MARK: - Initialize
    
    init(person: PersonRepresentable, signedIn: Bool) {
        self.person = person
        self.personDataManager = PersonDataManager(personID: person.id)
        self.signedIn = signedIn
        self.dataSource = MovieCollectionDataSource(emptyMessage: "emptyMoviesMessage".localized)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        personDetailView.moviesCollectionView.register(PosterImageCollectionViewCell.nib, forCellWithReuseIdentifier: PosterImageCollectionViewCell.reuseId)
        personDetailView.moviesCollectionView.register(NoDataCollectionViewCell.nib, forCellWithReuseIdentifier: NoDataCollectionViewCell.reuseId)
        personDetailView.moviesCollectionView.delegate = self
        personDetailView.moviesCollectionView.dataSource = dataSource
        
        personDataManager.failureDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        let loadingSelector = #selector(PersonDetailViewController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(PersonDetailViewController.dataManagerDidUpdate(notification:))
        personDataManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)
        
        personDataManager.reloadIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
        
        personDataManager.remove(observer: self)
    }
    
    // MARK: - Notifications
    
    override func dataManagerDidStartLoading(notification: Notification) {
         personDetailView.set(state: .loading)
    }
    
    override func dataManagerDidUpdate(notification: Notification) {
        if let person = personDataManager.person {
            
            // Collection view
            if person.movieCredits.count > 0 {
                dataSource.items = person.movieCredits
                personDetailView.moviesCollectionView.reloadData()
                personDetailView.moviesStackView.isHidden = false
            }
            
            // View
            personDetailView.set(state: .idle)
            personDetailView.configure(person: person)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func homepageButtonClick(_ sender: UIButton) {
        guard let person = personDataManager.person, let url = person.homepage else {
            return
        }
      
        safariVC = SFSafariViewController(url: url)
        safariVC?.delegate  = self
        present(safariVC!, animated: true, completion: nil)
    }
    
    @IBAction func disclosureButonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        personDetailView.setBiographyLabel(expanded: !biographyExpanded, animated: true)
        biographyExpanded = !biographyExpanded
    }
    
    @IBAction func backButtonClick(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - DataManagerFailureDelegate
    
    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
        personDetailView.set(state: .idle)
        
        guard error != .generic else {
            personDetailView.configure(personRespresentable: self.person)
            return
        }
        
        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
    }
}

// MARK: - UICollectionViewDelegate

extension PersonDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         guard let movie = dataSource.item(atIndex: indexPath.row) else { return }
         let detailViewController = DetailViewController(movie: movie, signedIn: signedIn)
         navigationController?.pushViewController(detailViewController, animated: true)
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

// MARK: - SFSafariViewControllerDelegate

extension PersonDetailViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true) {
            self.safariVC = nil
        }
    }
}
