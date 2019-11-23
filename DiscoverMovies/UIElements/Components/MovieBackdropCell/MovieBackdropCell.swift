//
//  MovieBackdropCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23/11/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit
import SDWebImage

final class MovieBackdropCell: UICollectionViewCell, Reusable {

    // MARK: Properties

    private lazy var titleLabel: UILabel = {
        return MovieBackdropCell.label(with: UIFont.H1())
    }()

    private lazy var subtitleLabel: UILabel = {
        return MovieBackdropCell.label(with: UIFont.H3())
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(labelStackView)

        let constraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            labelStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: labelStackView.trailingAnchor, constant: 20)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Configure

    func configure(with viewModel: MovieBackDropCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        imageView.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage.placeholderImage())
    }

    // MARK: Reuse

    override func prepareForReuse() {
        super.prepareForReuse()
    
        imageView.image = nil
    }

    // MARK: Helper

    private static func label(with font: UIFont?) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 1
        return label
    }
}
