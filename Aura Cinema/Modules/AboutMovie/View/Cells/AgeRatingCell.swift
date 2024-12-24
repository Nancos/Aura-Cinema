//
//  AgeRatingCell.swift
//  Aura Cinema
//
//  Created by MacBook Air on 7.01.25.
//
import UIKit

class AgeRatingCell: UITableViewCell {
    
    // MARK: - UI Elements -
    private let ageRatingLabel = UILabel()
    
    // MARK: - Configure -
    func configure(with ageRating: String) {
        ageRatingLabel.text = ageRating
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
private extension AgeRatingCell {
    
    func setupUI() {
        setupLabel()
        
        setupConstraints()
    }
    
    func setupLabel() {
        ageRatingLabel.font = UIFont(name: "AvenirNext-Bold", size: 16)
        ageRatingLabel.textColor = UIColor(named: "Background")
        ageRatingLabel.backgroundColor = UIColor(named: "forLabel")
        ageRatingLabel.layer.borderColor = UIColor.systemGray4.cgColor
        ageRatingLabel.layer.borderWidth = 1
        
        addSubview(ageRatingLabel)
    }
    
    func setupConstraints() {
        ageRatingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
