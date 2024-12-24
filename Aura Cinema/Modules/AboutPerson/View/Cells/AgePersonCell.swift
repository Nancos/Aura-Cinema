//
//  BirthdayPersonCell.swift
//  Aura Cinema
//
//  Created by MacBook Air on 13.01.25.
//

import UIKit

class AgePersonCell: UITableViewCell {
    // MARK: - UI Elements -
    private let ageLabel = UILabel()
    // MARK: - Configure -
    func configurate(with age: String) {
        ageLabel.text = age
    }
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .background
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privtate Methods -
private extension AgePersonCell {
    func setupUI() {
        setupPhotoImageView()
        
        setupConstraints()
    }
    
    func setupPhotoImageView() {
        addSubview(ageLabel)
    }
    
    func setupConstraints() {
        ageLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
    }
}
