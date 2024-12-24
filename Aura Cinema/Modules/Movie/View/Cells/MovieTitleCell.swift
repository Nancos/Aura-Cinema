//
//  TitlePosterCell.swift
//  Aura Cinema
//
//  Created by MacBook Air on 7.01.25.
//

import UIKit

class MovieTitleCell: UITableViewCell {
    // MARK: - UI Elements -
    private let titleLabel = UILabel()
    private let originalTitleLabel = UILabel()
    
    // MARK: - Configure -
    func configure(with data: ModelMovieTitleCell) {
        titleLabel.text = data.title
        originalTitleLabel.text = data.originalTitle
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
private extension MovieTitleCell {
    
    func setupUI() {
        setupTitleLabel()
        setupOriginalTitleLabel()
        
        setupConstraints()
    }
    
    func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = UIColor(named: "forColor")
        
        addSubview(titleLabel)
    }
    
    func setupOriginalTitleLabel() {
        originalTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        originalTitleLabel.textColor = UIColor(named: "forColor")
        
        addSubview(originalTitleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        originalTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
}
