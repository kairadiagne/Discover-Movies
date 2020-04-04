//
//  CastCollectionViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 03/04/2020.
//  Copyright © 2020 Kaira Diagne. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

final class CastCollectionViewController: UICollectionViewController {
    
//    private let castDataSource = CastDataSource(emptyMessage: "noCastmembersText".localized)

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        detailView.similarMovieCollectionView.register(PosterImageCollectionViewCell.nib, forCellWithReuseIdentifier: PosterImageCollectionViewCell.reuseId)
//                  detailView.similarMovieCollectionView.register(NoDataCollectionViewCell.nib, forCellWithReuseIdentifier: NoDataCollectionViewCell.reuseId)
//                  detailView.castCollectionView.register(PosterImageCollectionViewCell.nib, forCellWithReuseIdentifier: PosterImageCollectionViewCell.reuseId)
//                  detailView.castCollectionView.register(NoDataCollectionViewCell.nib, forCellWithReuseIdentifier: NoDataCollectionViewCell.reuseId)
//
//
//                  detailView.castCollectionView.delegate = self
//

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
