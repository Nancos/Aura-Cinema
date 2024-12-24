import UIKit

protocol MovieActionsDelegate {
    func didLikedMovie(with movieId: Int)
    func didTappedMovie(with movieId: Int)
}

final class CollectionMovieView: UIView {
    
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    var delegate: MovieActionsDelegate?
    
    private var data: [MovieViewData] = []
    private var filmography: [ModelPersonFilmographyCell] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: [MovieViewData], filmography: [ModelPersonFilmographyCell] = []) {
        self.data = data
        self.filmography = filmography
        collectionView.reloadData()
    }
}

private extension CollectionMovieView {
    func setupUI() {
        setupCollectionView()
        setupFlowLayout()
        setupConstraint()
    }
    
    func setupCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: MovieCollectionCell.description())
        
        addSubview(collectionView)
    }
    
    func setupFlowLayout() {
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 110, height: 190)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
    }
    
    func setupConstraint() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CollectionMovieView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.description(), for: indexPath) as? MovieCollectionCell else {
            return UICollectionViewCell()
        }
        
        let roleInFilm = filmography.first(where: { $0.id == data[indexPath.row].id })?.description
        
        cell.configure(data: data[indexPath.row],
                       filmography: roleInFilm,
                       tapViewCompletion: { self.delegate?.didTappedMovie(with: $0)},
                       doubleTapViewCompletion: { self.delegate?.didLikedMovie(with: $0)})
        return cell
    }
}
