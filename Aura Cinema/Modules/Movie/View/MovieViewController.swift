import UIKit

final class MovieViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - UI Elements -
    private let tableView = UITableView()
    private let descriptionView = MovieDescriptionCell()
    private let moviePersonCell = MoviePersonCell()
    private let personView = PersonView()
    private let navigationBar = NavigationBarViewController()
    
    // MARK: - Presenter
    private let presenter = MoviePresenter()
    
    // MARK: - Methods -
    private var movieId = 0
    private var items: [MovieCellItem] = []
    
    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchMovieCard(kpId: movieId)
    }
    
    // MARK: - Init -
    init(movieId: Int) {
        super.init(nibName: nil, bundle: nil)
        self.movieId = movieId
        presenter.fetchMovieCard(kpId: movieId)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods -
private extension MovieViewController {
    func setupUI() {
        setupView()
        setupNavigationBar()
        setupTableView()
        registerCells()
        
        setupConstraints()
    }
    
    func setupView() {
        presenter.delegate = self
        descriptionView.delegate = self
        personView.delegate = self
    }
    
    func setupNavigationBar() {
        view.addSubview(navigationBar)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
    }
    
    func registerCells() {
        tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.description())
        tableView.register(MovieTitleCell.self, forCellReuseIdentifier: MovieTitleCell.description())
        tableView.register(MovieInfoCell.self, forCellReuseIdentifier: MovieInfoCell.description())
        tableView.register(MovieButtonsCell.self, forCellReuseIdentifier: MovieButtonsCell.description())
        tableView.register(MovieDescriptionCell.self, forCellReuseIdentifier: MovieDescriptionCell.description())
        tableView.register(MoviePersonCell.self, forCellReuseIdentifier: MoviePersonCell.description())
    }
    
    func setupConstraints() {
        navigationBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(navigationBar.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource -
extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        return configureTableView(item: item, indexPath: indexPath) ?? UITableViewCell()
    }
}

// MARK: - Helper configure cell -
private extension MovieViewController {
    private func configureTableView(item: MovieCellItem, indexPath: IndexPath) -> UITableViewCell? {
        switch item {
            case .moviePoster(let model): return configureMoviePosterCell(model.posterURL, indexPath: indexPath)
            case .movieTitle(let model): return configureMovieTitleCell(model, indexPath: indexPath)
            case .movieInfo(let model): return configureMovieInfoCell(model, indexPath: indexPath)
            case .movieButtons(let model): return configureMovieButtonsCell(model, indexPath: indexPath)
            case .movieDescription(let model): return configureMovieDescriptionCell(model, indexPath: indexPath)
            case .moviePerson(let model): return configureMoviePersonCell(model, indexPath: indexPath)
        }
    }
    
    func configureMoviePosterCell(_ urlString: String, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.description(), for: indexPath) as? PhotoCell
        cell?.configure(with: urlString)
        return cell
    }
    
    func configureMovieTitleCell(_ model: ModelMovieTitleCell, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTitleCell.description(), for: indexPath) as? MovieTitleCell
        cell?.configure(with: model)
        return cell
    }
    
    func configureMovieInfoCell(_ model: ModelMovieInfoCell, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoCell.description(), for: indexPath) as? MovieInfoCell
        cell?.configure(with: model)
        return cell
    }
    
    func configureMovieButtonsCell(_ model: ModelMovieButtonsCell, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieButtonsCell.description(), for: indexPath) as? MovieButtonsCell
        cell?.delegate = self
        cell?.configure(with: model)
        return cell
    }
    
    func configureMovieDescriptionCell(_ model: ModelMovieDescriptionCell, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDescriptionCell.description(), for: indexPath) as? MovieDescriptionCell
        cell?.configure(with: model)
        cell?.delegate = self
        return cell
    }
    
    func configureMoviePersonCell(_ model: [ModelMoviePersonCell], indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviePersonCell.description(), for: indexPath) as! MoviePersonCell
        cell.configure(with: model)
        cell.collectionPersonView.delegate = self
        return cell
    }
}

// MARK: - MovieDelegate -
extension MovieViewController: MovieDelegate {
    func configureMovieWithError(title: String, message: String, alertType: AlertType) {
        self.items = []
        showAlert(title: title, message: message, alertType: alertType)
    }
    
    func configureMovie(with card: [MovieCellItem]) {
        self.items = card
        self.tableView.reloadData()
    }
}


// MARK: - MovieDescriptionDelgate -
extension MovieViewController: MovieDescriptionDelgate {
    func didTapMoreButton(with items: ModelMovieDescriptionCell) {
        
        let aboutMovieVC = AboutMovieViewController(with: [
            .title(items.title),
            .shortDescription(items.shortDescription),
            .description(items.description),
            .ageRating(items.ageRating)
        ])
        present(aboutMovieVC, animated: true)
    }
}


// MARK: - MoviePersonDelgate -
extension MovieViewController: MoviePersonDelgate {
    func didTapPerson(with id: Int) {
        let aboutPersonVC = AboutPersonViewController(with: id)
        navigationController?.pushViewController(aboutPersonVC, animated: true)
    }
}


// MARK: - MovieButtonsCellDelegate -
extension MovieViewController: MovieButtonsCellDelegate {
    func didTappedLikeButton(with movieId: Int) {
        presenter.didLikeMovie(withID: movieId)
    }
    
    func didTapTrailerButton() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func didSelectTrailer(with url: String) {
        let playerVC = PlayerViewController()
        playerVC.configure(with: url) // Передаем URL трейлера
        navigationController?.pushViewController(playerVC, animated: true)
    }
}
