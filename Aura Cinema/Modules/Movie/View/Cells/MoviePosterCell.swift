//
//  PosterCell.swift
//  Aura Cinema
//
//  Created by MacBook Air on 7.01.25.
//

import UIKit

class MoviePosterCell: UITableViewCell {
    // MARK: - UI Elements -
    private let posterImageView = UIImageView()
    
    // MARK: - Configure -
    func configure(with data: ModelMoviePosterCell) {
        posterImageView.kf.setImage(with: URL(string: data.posterURL),
                                    placeholder: nil,
                                    options: [.transition(.fade(0.4))])
    }
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods -
private extension MoviePosterCell {
    
    func setupUI() {
        setupPosterView()
        
        setupConstraints()
    }
    
    func setupPosterView() {
        posterImageView.contentMode = .scaleAspectFit
        
        addSubview(posterImageView)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.5) // устанавливаем соотношение сторон
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
