//
//  GrowthPersonCell.swift
//  Aura Cinema
//
//  Created by MacBook Air on 13.01.25.
//

import UIKit

class GrowthPersonCell: UITableViewCell {
    // MARK: - UI Elements -
    private let growthLabel = UILabel()
    // MARK: - Configure -
    func configurate(with growth: String) {
        growthLabel.text = growth
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
private extension GrowthPersonCell {
    func setupUI() {
        setupPhotoImageView()
        
        setupConstraints()
    }
    
    func setupPhotoImageView() {
        addSubview(growthLabel)
    }
    
    func setupConstraints() {
        growthLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
    }
}

