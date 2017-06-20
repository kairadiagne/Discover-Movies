//
//  SegmentedView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-06-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

protocol SegmentedViewDelegate: class {
    func segmentedView(_ view: SegmentedView, changedSegmentedIndexToValue toValue: Int, fromValue: Int)
}

class SegmentedView: UIView {
    
    // MARK: - Constants 
    
    private struct Constants {
        static let HorizontalOffSet: CGFloat = 20
        static let ControlHeight: CGFloat = 40
        static let ControlBottom: CGFloat = 10
    }
    
    // MARK: - Properties
    
    private let segmentedControl: UISegmentedControl
    
    private let pageView: UIView
    
    private var currentSelectedIndex = 0
    
    weak var delegate: SegmentedViewDelegate?
    
    // MARK: - Initialize
    
    init(frame: CGRect, segmentTitles: [String] = [], pageView: UIView) {
        self.pageView = pageView
        self.segmentedControl = UISegmentedControl(items: segmentTitles)
        super.init(frame: frame)
        
        addSubview(segmentedControl)
        addSubview(pageView)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        pageView.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.HorizontalOffSet).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.HorizontalOffSet).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: Constants.ControlHeight)
        
        pageView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: Constants.ControlBottom).isActive = true
        pageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        pageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        pageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let changeSelector = #selector(segmentedControlValueChanged(_:))
        segmentedControl.addTarget(self, action: changeSelector, for: .valueChanged)
        
        segmentedControl.tintColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions 
    
    @objc private func segmentedControlValueChanged(_ control: UISegmentedControl) {
        let oldSegmentedIndex = currentSelectedIndex
        currentSelectedIndex = segmentedControl.selectedSegmentIndex
        delegate?.segmentedView(self, changedSegmentedIndexToValue: currentSelectedIndex, fromValue: oldSegmentedIndex)
    }
    
    func set(selectedIndex index: Int) {
        currentSelectedIndex = index
        segmentedControl.selectedSegmentIndex = currentSelectedIndex
    }

}
