import UIKit

final class AboutPersonViewController: UIViewController {
    
    // MARK: - UI Elements -
    private let tableView = UITableView()
    private let navigationBar = NavigationBarViewController()
    
    // MARK: - Presenter -
    private let presenter = PersonPresenter()
    
    // MARK: - Methods -
    var persons: [PersonCellItem] = []
    var movies: [MovieViewData] = []
    
    // MARK: - Init -
    init(with id: Int) {
        super.init(nibName: nil, bundle: nil)
        presenter.delegate = self
        presenter.fetchPersonData(with: id)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods -

private extension AboutPersonViewController {
    func setupUI() {
        setupTableView()
        setupNavigationBar()
        setupConstraints()
    }
    
    func setupNavigationBar() {
        view.addSubview(navigationBar)
    }
    
    func setupTableView() {
        tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.description())
        tableView.register(TitlePersonCell.self, forCellReuseIdentifier: TitlePersonCell.description())
        tableView.register(AboutPersonCell.self, forCellReuseIdentifier: AboutPersonCell.description())
        tableView.register(FilmographyPersonCell.self, forCellReuseIdentifier: FilmographyPersonCell.description())
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .background
        
        view.addSubview(tableView)
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
extension AboutPersonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = persons[indexPath.row]
        return configureTableView(item: item, indexPath: indexPath) ?? UITableViewCell()
    }
}


// MARK: - Helper configure cell -
private extension AboutPersonViewController {
    
    private func configureTableView(item: PersonCellItem, indexPath: IndexPath) -> UITableViewCell? {
        switch item {
            case .personPhoto(let model): return configurePhotoPersonCell(model.photoURL, indexPath: indexPath)
            case .personName(let model): return configureTitlePersonCell(model, indexPath: indexPath)
            case .personSex(let model): return configureAboutPersonCell(model.sex, indexPath: indexPath)
            case .personGrowth(let model): return configureAboutPersonCell(model.growth, indexPath: indexPath)
            case .personBirthday(let model): return configureAboutPersonCell(model.birthday, indexPath: indexPath)
            case .personDeath(let model): return configureAboutPersonCell(model.death, indexPath: indexPath)
            case .personAge(let model): return configureAboutPersonCell(model.age, indexPath: indexPath)
            case .personFilmography(let model): return configureFilmographyPersonCell(model, indexPath: indexPath)
        }
    }
    
    func configurePhotoPersonCell(_ urlString: String, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.description(), for: indexPath) as? PhotoCell
        cell?.configure(with: urlString)
        return cell
    }
    
    func configureTitlePersonCell(_ model: ModelPersonNameCell, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitlePersonCell.description(), for: indexPath) as? TitlePersonCell
        cell?.configure(with: model.name)
        return cell
    }
    
    func configureAboutPersonCell(_ model: String, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: AboutPersonCell.description(), for: indexPath) as? AboutPersonCell
        cell?.configure(with: model)
        return cell
    }
    
    func configureFilmographyPersonCell(_ model: [ModelPersonFilmographyCell], indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmographyPersonCell.description(), for: indexPath) as? FilmographyPersonCell
        cell?.configure(with: model, with: movies)
        cell?.delegate = self
        return cell
    }
}

// MARK: - PersonDelegate -
extension AboutPersonViewController: PersonDelegate {
    func showError(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
    
    func configureView(with persons: [PersonCellItem], with movies: [MovieViewData]) {
        self.persons = persons
        self.movies = movies
        self.tableView.reloadData()
    }
}

// MARK: - MovieActionsDelegate -
extension AboutPersonViewController: MovieActionsDelegate {
    func didTappedMovie(with movieId: Int) {
        let tabBarVC = TabBarViewController()
        let currentVC = self
        let movieVC = MovieViewController(movieId: movieId)
        navigationController?.setViewControllers([tabBarVC, currentVC, movieVC], animated: true)
    }
    
    func didLikedMovie(with movieId: Int) {
        presenter.didLikeMovie(withID: movieId)
    }
}
