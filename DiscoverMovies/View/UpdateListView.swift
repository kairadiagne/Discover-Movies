//
//  UpdateListView.swift
//  Discover
//
//  Created by Kaira Diagne on 29-02-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import ChameleonFramework

protocol UpdateListViewDelegate: class {
    // Gets called when the user has pressed the button to add something to a list
    func updateListViewDidAddItemToList(identifier: String, listView: UpdateListView)
    // Gets called when the user has pressed the button to remove something from a list
    func updateListViewDidRemoveItemFromList(identifier: String, listView: UpdateListView)
}

@IBDesignable
class UpdateListView: UIView {
    
    // MARK: Properties
    
    weak var delegate: UpdateListViewDelegate?
    @IBInspectable var fillColor: UIColor = UIColor.flatSkyBlueColor()
    @IBInspectable var borderColor: UIColor = UIColor.flatSkyBlueColor()
    @IBInspectable var lineWidth: CGFloat = 1.0
    var inList = false { didSet { setNeedsDisplay() } }
    var identifier: String { return "" }
    
    // MARK: - Initializerss
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    private func configureUI() {
        self.backgroundColor = UIColor.clearColor()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UpdateListView.updateListViewDidGetTapped(_:)))
        self.addGestureRecognizer(tap)
    }
    
    // MARK: - Gestures 
    
    func updateListViewDidGetTapped(sender: UITapGestureRecognizer) {
        guard let delegate = delegate else { return }
        if inList {
//            toggleState()
            delegate.updateListViewDidRemoveItemFromList(identifier, listView: self)
        } else {
//            toggleState()
            delegate.updateListViewDidAddItemToList(identifier, listView: self)
        }
    }
    
    // MARK: - Toggle State
    
    func toggleState() {
        inList = !inList
    }
    
}