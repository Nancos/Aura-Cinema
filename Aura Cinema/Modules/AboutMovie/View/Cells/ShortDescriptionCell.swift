//
//  ShortDescriptionCell.swift
//  Aura Cinema
//
//  Created by MacBook Air on 7.01.25.
//
import UIKit

class ShortDescriptionCell: UITableViewCell {
    
    // MARK: - UI Elements -
    private let shortDescriptionLabel = UILabel()
    
    // MARK: - Configure -
    func configure(with shortDescription: String) {
        shortDescriptionLabel.text = shortDescription
    }
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods -

private extension ShortDescriptionCell {
    
    func setupUI() {
        setupLabel()
        
        setupConstraints()
    }
    
    func setupLabel() {
        shortDescriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        shortDescriptionLabel.textColor = UIColor(named: "forLabel")
        shortDescriptionLabel.numberOfLines = 0
        
        addSubview(shortDescriptionLabel)
    }
    
    func setupConstraints() {
        shortDescriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}
