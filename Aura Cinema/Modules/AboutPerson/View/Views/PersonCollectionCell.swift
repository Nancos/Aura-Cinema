//
//  PersonCollectionCell.swift
//  Aura Cinema
//
//  Created by MacBook Air on 20.01.25.
//
import UIKit

class PersonCollectionCell: UICollectionViewCell {
    
    private let personView = PersonView()
    
    var delegate: MoviePersonDelgate? {
        didSet {
            personView.delegate = delegate
        }
    }
    
    func configure(with data: ModelMoviePersonCell) {
        backgroundColor = .clear
        personView.configure(data: data)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PersonCollectionCell {
    func setupUI() {
        setupPersonView()
        
        setupConstraints()
    }
    
    func setupPersonView() {
        contentView.addSubview(personView)
    }
    
    func setupConstraints() {
        personView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
