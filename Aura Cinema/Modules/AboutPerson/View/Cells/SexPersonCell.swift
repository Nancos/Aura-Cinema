//
//  SexPersonCell.swift
//  Aura Cinema
//
//  Created by MacBook Air on 13.01.25.
//

import UIKit

class SexPersonCell: UITableViewCell {
    // MARK: - UI Elements -
    private let sexLabel = UILabel()
    // MARK: - Configure -
    func configurate(with sex: String) {
        sexLabel.text = sex
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
private extension SexPersonCell {
    func setupUI() {
        setupPhotoImageView()
        
        setupConstraints()
    }
    
    func setupPhotoImageView() {
        addSubview(sexLabel)
    }
    
    func setupConstraints() {
        sexLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
    }
}
