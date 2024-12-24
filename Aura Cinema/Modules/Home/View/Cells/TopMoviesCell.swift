import UIKit

final class TopMoviesCell: UITableViewCell {
    
    // MARK: - UI Elements -
    private let collectionLabel = LabelView()
    private let collectionMovieView = CollectionMovieView()
    
    // MARK: - Delegate -
    var delegate: MovieActionsDelegate?
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    func configure(data: [MovieViewData], top: String) {
        collectionLabel.configure(text: top)
        collectionMovieView.configure(with: data)
    }
}

private extension TopMoviesCell {
    
    func setupUI() {
        setupView()
        setupLabel()
        setupCollectionView()
        
        setupConstraints()
    }
    
    func setupView() {
        backgroundColor = .background
        selectionStyle = .none
        collectionMovieView.delegate = self
    }
    
    func setupLabel() {
        contentView.addSubview(collectionLabel)
    }
    
    func setupCollectionView() {
        contentView.addSubview(collectionMovieView)
    }
    
    func setupConstraints() {
        collectionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        
        collectionMovieView.snp.makeConstraints { make in
            make.top.equalTo(collectionLabel.snp.bottom)
            make.height.equalTo(200)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
}


// MARK: - MovieActionsDelegate -
extension TopMoviesCell: MovieActionsDelegate {
    func didLikedMovie(with movieId: Int) {
        delegate?.didLikedMovie(with: movieId)
    }
    
    func didTappedMovie(with movieId: Int) {
        delegate?.didTappedMovie(with: movieId)
    }
}
