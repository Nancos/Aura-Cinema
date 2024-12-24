import UIKit

protocol MovieButtonsCellDelegate {
    func didTappedLikeButton(with movieId: Int)
    func didTapTrailerButton()
    func didSelectTrailer(with url: String)
}

final class MovieButtonsCell: UITableViewCell {
    // MARK: - UI Elements -
    private let likeButton = UIButton()
    private let shareButton = UIButton()
    private let trailerButton = UIButton()
    private let stackView = UIStackView()
    private let trailersTableView = UITableView()
    // MARK: - Delegate -
    var delegate: MovieButtonsCellDelegate?
    // MARK: - Method -
    private var id = 0
    private var trailers: [ModelMovieTrailers] = []
    private var isTableViewVisible = false
    private var saved = false {
        didSet {
            likeButton.configuration?.baseForegroundColor = saved ? .red : .systemBlue
            likeButton.configuration?.title = saved ? String(localized: "Saved") : String(localized: "Save")
        }
    }
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ModelMovieButtonsCell) {
        id = model.id
        trailerButton.isEnabled = model.trailers.isEmpty ? false : true
        trailers = model.trailers
        saved = model.saved
        trailersTableView.reloadData()
    }
}

// MARK: - Private Methods -
private extension MovieButtonsCell {
    func setupUI() {
        setupView()
        setupStackView()
        setupLikeButton()
        setupTrailerButton()
        setupTrailersTableView()
        
        setupConstraints()
    }
    
    func setupView() {
        selectionStyle = .none
    }
    
    func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        contentView.addSubview(stackView)
    }
    
    func setupLikeButton() {
        setupButton(imageName: "heart", title: "Save", sender: likeButton)
        likeButton.addTarget(self, action: #selector(didTappedLikeButton), for: .touchUpInside)
        
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(likeButton)
    }

    func setupTrailerButton() {
        setupButton(imageName: "eye", title: String(localized: "Trailer"), sender: trailerButton)
        trailerButton.addTarget(self, action: #selector(didTapTrailerButton), for: .touchUpInside)
        
        stackView.addArrangedSubview(trailerButton)
        stackView.addArrangedSubview(UIView())
    }
    
    func setupTrailersTableView() {
        trailersTableView.delegate = self
        trailersTableView.dataSource = self
        trailersTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        trailersTableView.isHidden = true
        trailersTableView.separatorStyle = .singleLine
        trailersTableView.rowHeight = UITableView.automaticDimension
        contentView.addSubview(trailersTableView)
    }
    
    func setupButton(imageName: String, title: String, sender: UIButton) {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: imageName)
        config.imagePadding = 5
        config.imagePlacement = .top
        config.title = title
        config.titleAlignment = .center
        config.baseForegroundColor = .systemBlue
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 13)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { $0.font(UIFont.systemFont(ofSize: 13)) }
        sender.isUserInteractionEnabled = true
        sender.configuration = config
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(50) // Фиксированная высота кнопок
        }
        trailersTableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -
extension MovieButtonsCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trailers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trailer = trailers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        cell.textLabel?.text = "\(indexPath.row+1)." + trailer.name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTrailer = trailers[indexPath.row]
        delegate?.didSelectTrailer(with: selectedTrailer.url)
    }
}

private extension MovieButtonsCell {
    @objc func didTappedLikeButton() {
        delegate?.didTappedLikeButton(with: id)
        saved.toggle()
    }
    
    @objc func didTapTrailerButton() {
        isTableViewVisible.toggle()
        trailersTableView.isHidden = false
        let newHeight: CGFloat = isTableViewVisible ? CGFloat(trailers.count * 44) : 0
        trailersTableView.snp.updateConstraints { make in
            make.height.equalTo(newHeight)
        }
        UIView.animate(withDuration: 0.3) {
            self.contentView.layoutIfNeeded()
        }
        delegate?.didTapTrailerButton()
    }
}
