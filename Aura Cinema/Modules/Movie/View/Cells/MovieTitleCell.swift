import UIKit

final class MovieTitleCell: UITableViewCell {
    // MARK: - UI Elements -
    private let titleLabel = UILabel()
    private let originalTitleLabel = UILabel()
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    func configure(with data: ModelMovieTitleCell) {
        let currentLanguage = Locale.current.language.languageCode?.identifier
        if currentLanguage == "ru" {
            titleLabel.text = data.title
            originalTitleLabel.text = data.originalTitle
        } else if data.originalTitle.isEmpty {
            titleLabel.text = data.title
        } else {
            titleLabel.text = data.originalTitle
            originalTitleLabel.text = data.title
        }
    }
}

// MARK: - Private Methods -
private extension MovieTitleCell {
    
    func setupUI() {
        setupView()
        setupTitleLabel()
        setupOriginalTitleLabel()
        
        setupConstraints()
    }
    
    func setupView() {
        selectionStyle = .none
    }
    
    func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(named: "forColor")
        
        addSubview(titleLabel)
    }
    
    func setupOriginalTitleLabel() {
        originalTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        originalTitleLabel.textAlignment = .center
        originalTitleLabel.textColor = UIColor(named: "forColor")
        
        addSubview(originalTitleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        originalTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
}
