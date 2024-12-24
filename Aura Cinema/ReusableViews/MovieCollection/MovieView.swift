//
//  MovieStackView.swift
//  Aura Cinema
//
//  Created by MacBook Air on 26.12.24.
//

// MARK: - CoupleMovieStackViewDelegate -

import UIKit

class MovieView: UIView {
    
    // MARK: - UI Elements -
    private let movieImageView = UIImageView()
    private let movieTitleLabel = UILabel()
    private let ratingKPLabel = UILabel()
    private let ratingIMDBLabel = UILabel()
    lazy var heartImage = UIImageView()
    var filmographyDescriptionLabel = UILabel()

    // MARK: - Methods -
    private(set) var id = 0
    private var isLiked = false { didSet { toggleLike() } }
    
    // MARK: - Completion -
    private var tapViewCompletion: (Int) -> Void = { _ in }
    private var doubleTapViewCompletion: (Int) -> Void = { _ in }
    
    // MARK: - Initialization -

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.masksToBounds = false
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure - 
    
    func configure(with data: MovieViewData,
                   filmography: String?,
                   tapViewCompletion: @escaping (Int) -> Void, doubleTapViewCompletion: @escaping (Int) -> Void) {
        
        movieTitleLabel.text = data.title
        filmographyDescriptionLabel.text = filmography
        movieImageView.kf.setImage(with: URL(string: data.posterURL),
                                   placeholder: nil,
                                   options: [.transition(.fade(0.4))])
        ratingKPLabel.text = data.ratingKP
        ratingKPLabel.backgroundColor = data.ratingKPColor
        ratingIMDBLabel.text = data.ratingIMDB
        ratingIMDBLabel.backgroundColor = data.ratingIMDBColor
        isLiked = data.saved
        
        self.id = data.id
        self.tapViewCompletion = tapViewCompletion
        self.doubleTapViewCompletion = doubleTapViewCompletion
        addTapGesture(for: self)
    }
    
    func calculateHeight() -> CGFloat {
        return intrinsicContentSize.height
    }
}

// MARK: - Private Methods -

private extension MovieView {
    
    func setupUI() {
        setupImageView()
        setupRatingKP()
        setupRatingIMDB()
        setupLabel()
        setupFilmographyLabel()
        setupHeartImage()
        
        
        setupConstraint()
    }

    func setupImageView() {
        movieImageView.layer.cornerRadius = 15
        movieImageView.layer.borderWidth = 1
        movieImageView.layer.borderColor = UIColor.background.cgColor
        movieImageView.clipsToBounds = true
        
        addSubview(movieImageView)
    }
    
    func setupRatingKP() {
        settingsRatingLabel(ratingKPLabel)
        
        movieImageView.addSubview(ratingKPLabel)
    }
    
    func setupRatingIMDB() {
        settingsRatingLabel(ratingIMDBLabel)
        
        movieImageView.addSubview(ratingIMDBLabel)
    }
    
    func setupLabel() {
        movieTitleLabel.textColor = UIColor(named: "forLabel")
        movieTitleLabel.font = UIFont(name: "AvenirNext-Bold", size: 10)
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.textAlignment = .center
        
        addSubview(movieTitleLabel)
    }
    
    func setupFilmographyLabel() {
        filmographyDescriptionLabel.textColor = UIColor(named: "forLabel")
        filmographyDescriptionLabel.font = UIFont(name: "AvenirNext-Bold", size: 10)
        filmographyDescriptionLabel.textAlignment = .center
        filmographyDescriptionLabel.numberOfLines = 0
        addSubview(filmographyDescriptionLabel)
    }
    
    func setupHeartImage() {
        toggleLike()
        heartImage.image = UIImage(systemName: "heart.circle.fill")?.withRenderingMode(.alwaysOriginal)
        movieImageView.addSubview(heartImage)
    }
    
    
    private func setupConstraint() {
        
        filmographyDescriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        
        movieImageView.snp.makeConstraints { make in
            make.top.equalTo(filmographyDescriptionLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(160)
        }
        
        ratingIMDBLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(movieImageView.snp.top).offset(8)
        }
        
        ratingKPLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalTo(movieImageView.snp.bottom).offset(-8)
        }
        
        heartImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview() // Просто указываем leading и trailing
            make.height.equalTo(10)
            make.bottom.equalToSuperview() // Это позволяет элементу растягиваться по высоте, если есть место
        }
    }
}

// MARK: - Private Functions -
private extension MovieView {
    func settingsRatingLabel(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = UIColor(named: "forLabel")
        label.layer.cornerRadius = 5
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 0.5
        label.clipsToBounds = true
    }
    
    func toggleLike() {
        heartImage.isHidden = !isLiked
    }
}

private extension MovieView {
    func addTapGesture(for movieView: UIView) {
        // двойной тап
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        movieView.addGestureRecognizer(doubleTapGestureRecognizer)
        // одиночный тап
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleViewTap(_:)))
        movieView.addGestureRecognizer(singleTapGestureRecognizer)
        // зависимость одиночного от двойного тапа
        singleTapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
    }

    @objc func handleViewTap(_ sender: UITapGestureRecognizer) {
        tapViewCompletion(id)
    }
    
    @objc func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        doubleTapViewCompletion(id)
        isLiked.toggle()
    }
}
