import UIKit

// MARK: - MovieDescriptionDelgate -
protocol MovieDescriptionDelgate {
    func didTapMoreButton(with items: ModelMovieDescriptionCell)
}

final class MovieDescriptionCell: UITableViewCell {
    // MARK: - UI Elements -
    private let shortDescriptionLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let moreButton = UIButton()
    
    // MARK: - Delegate -
    var delegate: MovieDescriptionDelgate?
    
    private var aboutMovie = ModelMovieDescriptionCell()
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    func configure(with data: ModelMovieDescriptionCell) {
        shortDescriptionLabel.text = data.shortDescription
        descriptionLabel.text = data.description
        aboutMovie = data
    }
}

// MARK: - Private Methods -
private extension MovieDescriptionCell {
    
    func setupUI() {
        setupView()
        setupDescriptionLabel()
        setupMoreButton()
        setupShortDescriptionLabel()
        
        setupConstraints()
    }
    
    func setupView() {
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
    }
    
    func setupShortDescriptionLabel() {
        shortDescriptionLabel.numberOfLines = 3
        shortDescriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .black)
        
        addSubview(shortDescriptionLabel)
    }
    
    func setupDescriptionLabel() {
        descriptionLabel.numberOfLines = 3
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        addSubview(descriptionLabel)
    }
    
    func setupMoreButton() {
        moreButton.setTitle(String(localized: "details_movie"), for: .normal)
        moreButton.setTitleColor(.systemOrange, for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        
        addSubview(moreButton)
    }
    
    @objc func didTapMoreButton() {
        delegate?.didTapMoreButton(with: aboutMovie)
    }
    
    func setupConstraints() {
        shortDescriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(shortDescriptionLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
