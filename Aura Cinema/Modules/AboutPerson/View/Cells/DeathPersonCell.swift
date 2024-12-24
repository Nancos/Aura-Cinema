//
//  BirthdayPersonCell.swift
//  Aura Cinema
//
//  Created by MacBook Air on 13.01.25.
//

import UIKit

class DeathPersonCell: UITableViewCell {
    // MARK: - UI Elements -
    private let deathLabel = UILabel()
    // MARK: - Configure -
    func configurate(with death: String) {
        deathLabel.text = death
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
private extension DeathPersonCell {
    func setupUI() {
        setupPhotoImageView()
        setupConstraints()
    }
    
    func setupPhotoImageView() {
        addSubview(deathLabel)
    }
    
    func setupConstraints() {
        deathLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
    }
}
