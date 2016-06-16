//
//  SearchView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 11-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import IQDropDownTextField

class SearchView: UIView {
    
    // MARK: Properties 
    
    @IBOutlet weak var discoverLabel: UILabel!
    
    @IBOutlet weak var yearField: IQDropDownTextField!
    
    @IBOutlet weak var genreTextField: IQDropDownTextField!
    
    @IBOutlet weak var ratingTextField: IQDropDownTextField!
    
    @IBOutlet weak var searchByTitleLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var discoverButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: AwakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        discoverLabel.font = UIFont.H1()
        searchByTitleLabel.font = UIFont.H1()
        
        // Toolbar for IQtextFields
        let toolbar = UIToolbar()
        toolbar.barStyle = .Black
        toolbar.sizeToFit()
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneSelector = #selector(SearchView.done(_:))
        let done = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: doneSelector)
        toolbar.setItems([space, done], animated: false)
        
        // Configure textfields
        yearField.inputAccessoryView = toolbar
        yearField.isOptionalDropDown = true
        
        genreTextField.inputAccessoryView = toolbar
        genreTextField.isOptionalDropDown = true
        
        ratingTextField.inputAccessoryView = toolbar
        ratingTextField.isOptionalDropDown = true
    }
    
    // MARK: TextFields
    
    func registerTextFieldDelegate(IQField: IQDropDownTextFieldDelegate, textField: UITextFieldDelegate) {
        yearField.delegate = IQField
        genreTextField.delegate = IQField
        ratingTextField.delegate = IQField
        titleTextField.delegate = textField
    }
    
    func dataForTextFields(years: [String], genres: [String], ratings: [String]) {
        yearField.itemList = years
        genreTextField.itemList = genres
        ratingTextField.itemList = ratings
    }
    
    // MARK: Actions
    
    func done(button: UIBarButtonItem) {
        endEditing(true )
    }
  
}


