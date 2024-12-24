import UIKit

final class FilmographyPersonCell: UITableViewCell {
    
    var delegate: MovieActionsDelegate?
    
    // MARK: - UI Elements -
    private let filmograpyLabel = UILabel()
    private let collectionMovieView = CollectionMovieView()
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    func configure(with filmography: [ModelPersonFilmographyCell], with movies: [MovieViewData]) {
        self.collectionMovieView.configure(with: movies, filmography: filmography)
    }
}

// MARK: - Privtate Methods -
private extension FilmographyPersonCell {
    func setupUI() {
        setupView()
        setupfilmograpyLabel()
        setupCollectionMovieView()
        
        setupConstraints()
    }
    
    func setupView() {
        collectionMovieView.delegate = self
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func setupfilmograpyLabel() {
        filmograpyLabel.text = String(localized: "Filmography")
        filmograpyLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        contentView.addSubview(filmograpyLabel)
    }
    
    func setupCollectionMovieView() {
        collectionMovieView.backgroundColor = UIColor.background
        contentView.addSubview(collectionMovieView)
    }
    
    func setupConstraints() {
        filmograpyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        collectionMovieView.snp.makeConstraints { make in
            make.top.equalTo(filmograpyLabel.snp.bottom).offset(5)
            make.height.equalTo(200)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(0)
        }
    }
}

// MARK: - MovieActionsDelegate -
extension FilmographyPersonCell: MovieActionsDelegate {
    func didLikedMovie(with movieId: Int) {
        delegate?.didLikedMovie(with: movieId)
    }
    
    func didTappedMovie(with movieId: Int) {
        delegate?.didTappedMovie(with: movieId)
    }
}
