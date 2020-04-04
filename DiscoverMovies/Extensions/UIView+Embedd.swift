//
//  UIView+Embedd.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23/11/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit

extension UIView {

    func embed(subView: UIView) {
        addSubview(subView)

        subView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            subView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            subView.leadingAnchor.constraint(equalTo: leadingAnchor),
            subView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
