//
//  Title.swift
//  Aura Cinema
//
//  Created by MacBook Air on 10.01.25.
//
import UIKit
import Kingfisher

class PhotoPersonCell: UITableViewCell {
    // MARK: - UI Elements -
    private let photoImageView = UIImageView()
    // MARK: - Configure -
    func configurate(with photoURL: String) {
        photoImageView.kf.setImage(with: URL(string: photoURL),
                                   placeholder: nil,
                                   options: [.transition(.fade(0.4))])
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
private extension PhotoPersonCell {
    func setupUI() {
        setupPhotoImageView()
        
        setupConstraints()
    }
    
    func setupPhotoImageView() {
        addSubview(photoImageView)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.height.equalTo(photoImageView.snp.width).multipliedBy(1.5) // устанавливаем соотношение сторон
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
