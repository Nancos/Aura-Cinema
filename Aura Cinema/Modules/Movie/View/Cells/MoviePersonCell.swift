import UIKit

final class MoviePersonCell: UITableViewCell {
    
    // MARK: - UI Elements -
    let collectionPersonView = CollectionPersonView()
    
    // MARK: - Initialization -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    func configure(with data: [ModelMoviePersonCell]) {
        collectionPersonView.configure(with: data)
    }
}

// MARK: - Private Methods -
private extension MoviePersonCell {
    func setupUI() {
        setupView()
        setupCollectionPersonView()

        setupConstraints()
    }
    
    func setupView() {
        selectionStyle = .none
    }
    
    func setupCollectionPersonView() {
        contentView.addSubview(collectionPersonView)
    }

    func setupConstraints() {
        collectionPersonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(130)
        }
    }
}
