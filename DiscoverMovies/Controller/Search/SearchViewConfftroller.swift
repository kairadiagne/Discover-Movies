////
////  SearchViewController.swift
////  DiscoverMovies
////
////  Created by Kaira Diagne on 19-04-16.
////  Copyright © 2016 Kaira Diagne. All rights reserved.
////
//
//import UIKit
//import IQDropDownTextField
//import TMDbMovieKit
//
//struct Discover {
//    var year: String?
//    var genre: Int?
//    var vote: Float?
//}
//
//class SearchViewController: UIViewController, RevealMenuButtonShowable {
//    
//    private struct Storyboard {
//        static let DiscoverSegueIdentifier = "discover"
//        static let SearchByTitleSegueIdentifier = "searchByTitle"
//    }
//    
//    @IBOutlet weak var yearField: IQDropDownTextField!
//    @IBOutlet weak var genreField: IQDropDownTextField!
//    @IBOutlet weak var averageVoteField: IQDropDownTextField!
//    @IBOutlet weak var titleField: UITextField!
//    @IBOutlet weak var discoverMoviesButton: CustomButton!
//    @IBOutlet weak var searchByTitleButton: CustomButton!
//    
//    var discover = Discover()
//    var searchTitle: String?
//    
//    // MARK - Data Input IQDropDownTextField
//    
//    private var genres: [String] { return TMDbGenres.allGenresAsString() }
//    private let voteAverages: [String] = ["1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5", "5.5", "6", "6.5", "7", "7.5", "8", "8.5", "9", "9.5", "10"]
//    
//    private var years: [String] {
//        var years = [String]()
//        for i in 1950...NSDate().currentYear { years.insert("\(i)", atIndex: 0) }
//        return years
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//    
//        // Create toolbar for DropDownTextFields
//        let toolbar = UIToolbar()
//        toolbar.barStyle = UIBarStyle.Black
//        toolbar.sizeToFit()
//        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
//        let doneSelector = #selector(SearchViewController.done(_:))
//        let done = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: doneSelector)
//        toolbar.setItems([space, done], animated: false)
//        
//        configureMenuButton()
//        
//        // Configure IQDropDownTextFields and title textfield
//        yearField.configure(years, toolbar: toolbar, delegate: self)
//        genreField.configure(genres, toolbar: toolbar, delegate: self)
//        averageVoteField.configure(voteAverages, toolbar: toolbar, delegate: self)
//        titleField.delegate = self
//        
//        // Reset the searchFields and paramaters
//        yearField.selectedRow = 0
//        genreField.selectedRow = 0
//        averageVoteField.selectedRow = 0
//        titleField.text = ""
//        
//        discover = Discover()
//        searchTitle = nil
//    }
//    
//    // MARK: - Actions
//    
//    func done(sender: UIBarButtonItem) {
//        view.endEditing(true)
//    }
//    
//    @IBAction func cancel(sender: UIBarButtonItem) {
//        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    // MARK: - Error Alerts
//    
//    private func showDiscoverNotPossibleAlert() {
//        let title = "Discover not possible"
//        let message = "For discover a minimum of one search paramater is needed"
//        showAlertWithTitle(title, message: message, completionHandler: nil)
//    }
//    
//    private func showSearchNotPossibleAlert() {
//        let title = "Search not possible"
//        let message = "Please specify a title "
//        showAlertWithTitle(title, message: message, completionHandler: nil)
//    }
//    
//    // MARK: - Navigation
//    
//    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
//        if identifier == Storyboard.DiscoverSegueIdentifier {
//            if discover.year == nil && discover.genre == nil  && discover.vote == nil {
//                showDiscoverNotPossibleAlert()
//                return false
//            }
//        } else if identifier == Storyboard.SearchByTitleSegueIdentifier {
//            if searchTitle == nil {
//                showSearchNotPossibleAlert()
//                return false
//            }
//        }
//        return true
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let destination = segue.destinationViewController as? SearchTableViewController {
//            if segue.identifier == Storyboard.DiscoverSegueIdentifier {
//                destination.discover = discover
//            } else if segue.identifier == Storyboard.SearchByTitleSegueIdentifier {
//                destination.searchTitle = searchTitle
//            }
//        }
//    }
//    
//}
//
//// MARK: - IQDropDownTextFieldDelegate
//    
//extension SearchViewController: IQDropDownTextFieldDelegate {
//    
//    func textField(textField: IQDropDownTextField, didSelectItem item: String?) {
//        guard let selectedItem = item else { return }
//        let list = textField.itemList
//
//        let itemIsValid = item != "Select"
//        
//        if list == years {
//            discover.year = itemIsValid ? selectedItem : nil
//        } else if list == genres {
//            discover.genre = itemIsValid ? TMDbGenres.idForGenreWithName(selectedItem): nil
//        } else if list == voteAverages {
//            discover.vote = itemIsValid ? Float(selectedItem): nil
//        }
//    }
//
//}
//
//// MARK: - UITextFieldDelegate
//
//extension SearchViewController: UITextFieldDelegate {
//    
//    /* 
//     Since IQDropDownTextField is a subclass of UITextField these delegate methods not only get called whenever
//     the title text field changes but also when the IQDropDowntextfields change. During editing of the text fields 
//     the search buttons are disabled.
//    */
// 
//    func textFieldDidBeginEditing(textField: UITextField) {
//        discoverMoviesButton.enabled = false
//        searchByTitleButton.enabled = false
//    }
//    
//    /* 
//      When the user is done editing the title textfield we update the searchTitle variable.
//     The values from the IQDropDownTextFields are being saved when an items gets selected in 
//     the IQDropDownTextField delegate.
//    */
//
// 
//    func textFieldDidEndEditing(textField: UITextField) {
//        if !(textField is IQDropDownTextField) {
//            searchTitle = textField.text ?? ""
//        }
//        discoverMoviesButton.enabled = true
//        searchByTitleButton.enabled = true
//    }
//        
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//        
//}
