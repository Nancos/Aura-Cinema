import UIKit

class MovieViewController: UIViewController, UITableViewDelegate {
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
        presenter.delegate = self
        presenter.viewDelegate = self
        descriptionView.delegate = self
        personView.delegate = self
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
        setupNavigationBar()
        setupTableView()
        registerCells()
        
        setupConstraints()
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
        tableView.register(MoviePosterCell.self, forCellReuseIdentifier: "MoviePosterCell")
        tableView.register(MovieTitleCell.self, forCellReuseIdentifier: "MovieTitleCell")
        tableView.register(MovieInfoCell.self, forCellReuseIdentifier: "MovieInfoCell")
        tableView.register(MovieButtonsCell.self, forCellReuseIdentifier: "MovieButtonsCell")
        tableView.register(MovieDescriptionCell.self, forCellReuseIdentifier: "MovieDescriptionCell")
        tableView.register(MoviePersonCell.self, forCellReuseIdentifier: "MoviePersonCell")
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
        switch item {
        case .moviePoster(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoviePosterCell", for: indexPath) as! MoviePosterCell
            cell.configure(with: model)
            return cell
        case .movieTitle(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTitleCell", for: indexPath) as! MovieTitleCell
            cell.configure(with: model)
            return cell
        case .movieInfo(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoCell", for: indexPath) as! MovieInfoCell
            cell.configure(with: model)
            return cell
        case .movieButtons(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieButtonsCell", for: indexPath) as! MovieButtonsCell
            cell.delegate = self
            cell.configure(with: model)
            return cell
        case .movieDescription(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDescriptionCell", for: indexPath) as! MovieDescriptionCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .moviePerson(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoviePersonCell", for: indexPath) as! MoviePersonCell
            cell.collectionPersonView.delegate = self
            cell.configure(with: model)
            return cell
        }
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
        let aboutMovieVC = AboutMovieViewController(with: items)
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
    func didTappedShareButton(with movieId: Int) { print(movieId) }
    
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

extension MovieViewController: FavoritesUpdateDelegate {
    func didUpdateLikedMovies(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
    
    func showErrorFavoritesUpdate(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
}
