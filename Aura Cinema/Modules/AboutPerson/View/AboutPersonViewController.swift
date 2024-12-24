//
//  AboutPersonViewController.swift
//  Aura Cinema
//
//  Created by MacBook Air on 10.01.25.
//

import UIKit

class AboutPersonViewController: UIViewController {
    
    // MARK: - UI Elements -
    private let tableView = UITableView()
    private let navigationBar = NavigationBarViewController()
    
    private let presenter = PersonPresenter()
    // MARK: - Methods -
    var persons: [PersonCellItem] = []
    var movies: [MovieViewData] = []
    // MARK: - Init -
    init(with id: Int) {
        super.init(nibName: nil, bundle: nil)
        presenter.delegate = self
        presenter.viewDelegate = self
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
        tableView.register(PhotoPersonCell.self, forCellReuseIdentifier: "PhotoPersonCell")
        tableView.register(TitlePersonCell.self, forCellReuseIdentifier: "TitlePersonCell")
        tableView.register(SexPersonCell.self, forCellReuseIdentifier: "SexPersonCell")
        tableView.register(GrowthPersonCell.self, forCellReuseIdentifier: "GrowthPersonCell")
        tableView.register(DeathPersonCell.self, forCellReuseIdentifier: "DeathPersonCell")
        tableView.register(BirthdayPersonCell.self, forCellReuseIdentifier: "BirthdayPersonCell")
        tableView.register(AgePersonCell.self, forCellReuseIdentifier: "AgePersonCell")
        tableView.register(FilmographyPersonCell.self, forCellReuseIdentifier: "FilmographyPersonCell")
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
        switch item {
        case .personPhoto(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoPersonCell", for: indexPath) as! PhotoPersonCell
            cell.configurate(with: model.photoURL)
            return cell
        case .personName(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitlePersonCell", for: indexPath) as! TitlePersonCell
            cell.configurate(with: model.name)
            return cell
        case .personSex(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "SexPersonCell", for: indexPath) as! SexPersonCell
            cell.configurate(with: model.sex)
            return cell
        case .personGrowth(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrowthPersonCell", for: indexPath) as! GrowthPersonCell
            cell.configurate(with: model.growth)
            return cell
        case .personBirthday(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdayPersonCell", for: indexPath) as! BirthdayPersonCell
            cell.configurate(with: model.birthday)
            return cell
        case .personDeath(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeathPersonCell", for: indexPath) as! DeathPersonCell
            cell.configurate(with: model.death)
            return cell
        case .personAge(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgePersonCell", for: indexPath) as! AgePersonCell
            cell.configurate(with: model.age)
            return cell
        case .personFilmography(let models):
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilmographyPersonCell", for: indexPath) as! FilmographyPersonCell
            cell.configurate(with: models, with: movies)
            cell.delegate = self
            return cell
        }
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


// MARK: - FavoritesUpdateDelegate -
extension AboutPersonViewController: FavoritesUpdateDelegate {
    func didUpdateLikedMovies(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
    
    func showErrorFavoritesUpdate(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
}
