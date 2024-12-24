import UIKit

final class LabelView: UIView {
    // MARK: - UI Elements -
    private let label = UILabel()
    
    // MARK: - Init -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    public func configure(text: String) {
        label.text = text
    }
}

// MARK: - Private Methods -
private extension LabelView {
    func setupUI() {
        setupLabel()
        
        setupConstraints()
    }
    
    func setupLabel() {
        label.textColor = UIColor(named: "forLabel")
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)
        
        addSubview(label)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
