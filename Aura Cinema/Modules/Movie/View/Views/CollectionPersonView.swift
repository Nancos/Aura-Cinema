import UIKit

final class CollectionPersonView: UIView {
    // MARK: -UI Elements -
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    // MARK: -Data-
    private var data : [ModelMoviePersonCell] = []
    
    // MARK: - Delegate -
    var delegate: MoviePersonDelgate?
    
    // MARK: -Init-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Configure-
    func configure(with data: [ModelMoviePersonCell]) {
        self.data = data
        collectionView.reloadData()
    }
}

private extension CollectionPersonView {
    func setupUI() {
        setupCollectionView()
        setupFlowLayout()
        
        setupConstraint()
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PersonCollectionCell.self, forCellWithReuseIdentifier: PersonCollectionCell.description())
        addSubview(collectionView)
    }
    
    func setupFlowLayout() {
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 80, height: 120)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
    }
    
    func setupConstraint() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}

extension CollectionPersonView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionCell.description(), for: indexPath) as? PersonCollectionCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: data[indexPath.row])
        cell.delegate = delegate
        return cell
    }
}
