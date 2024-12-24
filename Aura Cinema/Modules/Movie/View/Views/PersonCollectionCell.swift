import UIKit

final class PersonCollectionCell: UICollectionViewCell {
    
    // MARK: - UI Elements -
    private let personView = PersonView()
    
    // MARK: - Delegate -
    var delegate: MoviePersonDelgate? {
        didSet {
            personView.delegate = delegate
        }
    }
    
    // MARK: - Init -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    func configure(with data: ModelMoviePersonCell) {
        personView.configure(data: data)
    }
}

private extension PersonCollectionCell {
    func setupUI() {
        setupView()
        setupPersonView()
        
        setupConstraints()
    }
    
    func setupView() {
        backgroundColor = .clear
    }
    
    func setupPersonView() {
        contentView.addSubview(personView)
    }
    
    func setupConstraints() {
        personView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
