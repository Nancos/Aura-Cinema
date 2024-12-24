//
//  TitleCell.swift
//  Aura Cinema
//
//  Created by MacBook Air on 7.01.25.
//
import UIKit

class TitleCell: UITableViewCell {
    
    // MARK: - UI Elements -
    private let titleLabel = UILabel()
    
    // MARK: - Configure -
    func configurate(with title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Init -
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
private extension TitleCell {
    
    func setupUI() {
        setupLabel()
        
        setupConstraints()
    }
    
    func setupLabel() {
        titleLabel.textColor = UIColor(named: "forLabel")
        titleLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        titleLabel.numberOfLines = 0
        
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
    }
}

