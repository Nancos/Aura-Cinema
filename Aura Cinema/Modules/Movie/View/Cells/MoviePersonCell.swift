//
//  MoviePersonCell.swift
//  Aura Cinema
//
//  Created by MacBook Air on 10.01.25.
//

import UIKit

class MoviePersonCell: UITableViewCell {
    // MARK: - Delegate -
    
    let collectionPersonView = CollectionPersonView()

    // MARK: - Configure -
    func configure(with data: [ModelMoviePersonCell]) {
        collectionPersonView.configure(with: data)
    }
    
    // MARK: - Initialization -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods -
private extension MoviePersonCell {
    func setupUI() {
        setupCollectionPersonView()

        setupConstraints()
    }
    
    func setupCollectionPersonView() {
        contentView.addSubview(collectionPersonView)
    }

    func setupConstraints() {
        collectionPersonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(130)
        }
    }
}
