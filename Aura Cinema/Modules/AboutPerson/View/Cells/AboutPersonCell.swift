import UIKit

final class AboutPersonCell: UITableViewCell {
    // MARK: - UI Elements -
    private let aboutLabel = UILabel()
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    func configure(with info: String) {
        aboutLabel.text = info
    }
}

// MARK: - Privtate Methods -
private extension AboutPersonCell {
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
        addSubview(aboutLabel)
    }
    
    func setupConstraints() {
        aboutLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
    }
}
