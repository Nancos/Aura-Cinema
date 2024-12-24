import UIKit

final class ShortDescriptionCell: UITableViewCell {
    
    // MARK: - UI Elements -
    private let shortDescriptionLabel = UILabel()
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    func configure(with shortDescription: String) {
        shortDescriptionLabel.text = shortDescription
    }
}

// MARK: - Private Methods -

private extension ShortDescriptionCell {
    
    func setupUI() {
        setupView()
        setupLabel()
        
        setupConstraints()
    }
    
    func setupView() {
        selectionStyle = .none
    }
    
    func setupLabel() {
        shortDescriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        shortDescriptionLabel.textColor = UIColor(named: "forLabel")
        shortDescriptionLabel.numberOfLines = 0
        
        addSubview(shortDescriptionLabel)
    }
    
    func setupConstraints() {
        shortDescriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}
