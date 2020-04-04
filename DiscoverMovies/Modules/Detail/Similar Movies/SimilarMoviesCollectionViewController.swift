//
//  SimilarMoviesCollectionViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 03/04/2020.
//  Copyright © 2020 Kaira Diagne. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

final class SimilarMoviesCollectionViewController: UICollectionViewController {
    
//     private let similarMoviesDataSource = MovieCollectionDataSource(emptyMessage: "noSimilarMoviesText".localized)
    //    private let similarMoviesManager: SimilarMoviesDataManager

    override func viewDidLoad() {
        super.viewDidLoad()
        
   
//               detailView.similarMovieCollectionView.dataSource = similarMoviesDataSource
//               detailView.similarMovieCollectionView.delegate = self
               

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

// MARK: - UICollectionViewDelegate

//extension MovieDetailViewController: UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == detailView.similarMovieCollectionView {
//            guard let movie = similarMoviesDataSource.item(atIndex: indexPath.row) else { return }
//            showDetailViewController(for: movie, signedIn: signedIn)
//        } else if collectionView == detailView.castCollectionView {
////            guard let person = castDataSource.item(atIndex: indexPath.row) else { return }
////            let personDetailViewController = PersonDetailViewController(person: person, signedIn: signedIn)
////            navigationController?.pushViewController(personDetailViewController, animated: true)
//        }
//    }
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//
//extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
//    
//    // Size of the specified item's cell
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView === detailView.similarMovieCollectionView {
//            return !similarMoviesDataSource.shouldShowEmptyMessage ? CGSize(width: 78, height: 130): detailView.similarMovieCollectionView.bounds.size
//        } else {
//            return .zero
////            return !castDataSource.shouldShowEmptyMessage ? CGSize(width: 78, height: 130): detailView.castCollectionView.bounds.size
//        }
//    }
//    
//    // Margins to apply to content in the specified section
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .zero
//    }
//    
//    // spacing between successive rows or columns of a section
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//    
//    // Spacing between successive items in the rows or columns of a section
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//}
