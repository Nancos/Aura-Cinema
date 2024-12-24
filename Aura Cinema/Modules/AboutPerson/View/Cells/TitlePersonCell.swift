import UIKit

final class TitlePersonCell: UITableViewCell {
    // MARK: - UI Elements -
    private let titleLabel = UILabel()
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    func configure(with name: String) {
        titleLabel.text = name
    }
}

// MARK: - Privtate Methods -
private extension TitlePersonCell {
    func setupUI() {
        setupView()
        setupLabel()
        
        setupConstraints()
    }
    
    func setupView() {
        selectionStyle = .none
        backgroundColor = .background
    }
    
    func setupLabel() {
        titleLabel.textColor = UIColor(named: "forLabel")
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.numberOfLines = 0
        
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
    }
}
