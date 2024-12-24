import UIKit

final class MovieView: UIView {
    
    // MARK: - UI Elements -
    private let posterImageView = CustomImageView()
    private let movieTitleLabel = UILabel()
    private let ratingKPLabel = InsetLabel()
    private let ratingIMDBLabel = InsetLabel()
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
        posterImageView.urlString = data.posterURL
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
        setupView()
        setupImageView()
        setupRatingKP()
        setupRatingIMDB()
        setupLabel()
        setupFilmographyLabel()
        setupHeartImage()
        
        
        setupConstraint()
    }
    
    func setupView() {
        backgroundColor = .clear
        layer.masksToBounds = false
    }

    func setupImageView() {
        posterImageView.layer.cornerRadius = 15
        posterImageView.layer.borderWidth = 1
        posterImageView.layer.borderColor = UIColor.background.cgColor
        posterImageView.clipsToBounds = true
        
        addSubview(posterImageView)
    }
    
    func setupRatingKP() {
        settingsRatingLabel(ratingKPLabel)
        
        posterImageView.addSubview(ratingKPLabel)
    }
    
    func setupRatingIMDB() {
        settingsRatingLabel(ratingIMDBLabel)
        
        posterImageView.addSubview(ratingIMDBLabel)
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
        posterImageView.addSubview(heartImage)
    }
    
    
    private func setupConstraint() {
        
        filmographyDescriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(filmographyDescriptionLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(160)
        }
        
        ratingIMDBLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(posterImageView.snp.top).offset(8)
        }
        
        ratingKPLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalTo(posterImageView.snp.bottom).offset(-8)
        }
        
        heartImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
            make.bottom.equalToSuperview()
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
