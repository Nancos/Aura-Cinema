import UIKit

protocol MoviePersonDelgate {
    func didTapPerson(with id: Int)
}

final class PersonView: UIView {
    
    // MARK: - Delegate -
    var delegate: MoviePersonDelgate?
    
    // MARK: - UI Elements -
    private let posterImageView = CustomImageView()
    private let nameLabel = UILabel()
    
    // MARK: - UI Elements -
    private(set) var id = 0
    
    // MARK: - Init -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    func configure(data: ModelMoviePersonCell) {
        posterImageView.urlString = data.personPhoto
        nameLabel.text = splitNameForLabel(data.personName)
        self.id = data.personID
        addTapGesture()
    }
}

// MARK: - Private Methods -
private extension PersonView {
    
    func setupUI() {
        setupView()
        setupImageView()
        setupNameLabel()
        
        setupConstraints()
    }
    
    func setupView() {
        backgroundColor = .clear
    }
    
    func setupImageView() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 40
        posterImageView.clipsToBounds = true
        
        addSubview(posterImageView)
    }
    
    func setupNameLabel() {
        nameLabel.font = .systemFont(ofSize: 12, weight: .medium)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        
        addSubview(nameLabel)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
                
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
    }
}

// MARK: - Private function - 
private extension PersonView {
    func splitNameForLabel(_ name: String) -> String {
        return name.replacingOccurrences(of: " ", with: "\n")
    }
}

// MARK: - Gesture Tap Person -
private extension PersonView {
    func addTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleViewTap(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleViewTap(_ sender: UITapGestureRecognizer) {
        delegate?.didTapPerson(with: id)
    }
}
