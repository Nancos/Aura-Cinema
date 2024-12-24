//
//  BirthdayPersonCell.swift
//  Aura Cinema
//
//  Created by MacBook Air on 13.01.25.
//

import UIKit

class BirthdayPersonCell: UITableViewCell {
    // MARK: - UI Elements -
    private let birthdayLabel = UILabel()
    // MARK: - Configure -
    func configurate(with birthday: String) {
        birthdayLabel.text = birthday
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
private extension BirthdayPersonCell {
    func setupUI() {
        setupPhotoImageView()
        
        setupConstraints()
    }
    
    func setupPhotoImageView() {
        addSubview(birthdayLabel)
    }
    
    func setupConstraints() {
        birthdayLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
    }
}
