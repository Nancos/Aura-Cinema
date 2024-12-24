import UIKit

final class AgeRatingCell: UITableViewCell {
    
    // MARK: - UI Elements -
    private let ageRatingLabel = UILabel()
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    func configure(with ageRating: String) {
        ageRatingLabel.text = ageRating
    }
}

// MARK: - Private Methods -
private extension AgeRatingCell {
    
    func setupUI() {
        setupView()
        setupLabel()
        
        setupConstraints()
    }
    
    func setupView() {
        selectionStyle = .none
    }
    
    func setupLabel() {
        ageRatingLabel.font = UIFont(name: "AvenirNext-Bold", size: 16)
        ageRatingLabel.textColor = UIColor(named: "Background")
        ageRatingLabel.backgroundColor = UIColor(named: "forLabel")
        ageRatingLabel.layer.borderColor = UIColor.systemGray4.cgColor
        ageRatingLabel.layer.borderWidth = 1
        
        addSubview(ageRatingLabel)
    }
    
    func setupConstraints() {
        ageRatingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
