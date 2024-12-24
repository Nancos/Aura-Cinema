import UIKit

final class PhotoCell: UITableViewCell {
    // MARK: - UI Elements -
    private let posterImageView = CustomImageView()
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    func configure(with photoURL: String) {
        posterImageView.urlString = photoURL
    }
}

// MARK: - Privtate Methods -
private extension PhotoCell {
    func setupUI() {
        setupView()
        setupPosterImageView()
        
        setupConstraints()
    }
    
    func setupView() {
        selectionStyle = .none
        backgroundColor = .background
    }
    
    func setupPosterImageView() {
        addSubview(posterImageView)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.5)
            make.edges.equalToSuperview()
        }
    }
}
