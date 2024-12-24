//
//  Title.swift
//  Aura Cinema
//
//  Created by MacBook Air on 10.01.25.
//
import UIKit

class TitlePersonCell: UITableViewCell {
    // MARK: - UI Elements -
    private let titleLabel = UILabel()
    
    // MARK: - Configure -
    func configurate(with name: String) {
        titleLabel.text = name
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
private extension TitlePersonCell {
    func setupUI() {
        setupLabel()
        
        setupConstraints()
    }
    
    func setupLabel() {
        titleLabel.textColor = UIColor(named: "forLabel")
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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
