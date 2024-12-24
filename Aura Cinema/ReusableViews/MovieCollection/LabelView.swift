//
//  Label.swift
//  Aura Cinema
//
//  Created by MacBook Air on 29.12.24.
//

import UIKit

class LabelView: UIView {
    // MARK: - UI Elements -
    private let label = UILabel()
    // MARK: - Configure -
    public func configure(text: String) {
        label.text = text
    }
    // MARK: - Init -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods -
private extension LabelView {
    func setupUI() {
        setupLabel()
        
        setupConstraints()
    }
    
    func setupLabel() {
        label.textColor = UIColor(named: "forLabel")
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)
        
        addSubview(label)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
