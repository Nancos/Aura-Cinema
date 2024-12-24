import UIKit

final class DescriptionCell: UITableViewCell {
    
    // MARK: - UI Elements -
    private let descriptionLabel = UILabel()
    
    // MARK: - Initilisation -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure-
    func configure(with description: String) {
        descriptionLabel.text = description
    }
}

// MARK: - Private Methods -
private extension DescriptionCell {
    
    func setupUI() {
        setupView()
        setupLabel()
        
        setupConstraints()
    }
    
    func setupView() {
        selectionStyle = .none
    }
    
    func setupLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        descriptionLabel.textColor = UIColor(named: "forLabel")
        descriptionLabel.numberOfLines = 0
        
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
