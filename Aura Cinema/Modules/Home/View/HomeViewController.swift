//
//  HomeViewController.swift
//  Aura Cinema
//
//  Created by MacBook Air on 29.12.24.
//
import UIKit
import SnapKit

class HomeViewController: UIViewController {
    // MARK: - UI Elements -
    private let tableView = UITableView()
    private let backgroundImageView = UIImageView()
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Presenter -
    private let presenter = HomePresenter()
    
    // MARK: - Data -
    private var movies: [(String, [MovieViewData])] = []
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.viewDelegate = self
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupGradientMask()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.fetchMovieData(with: [.top20of2023, .vampireMovies])
    }
}


private extension HomeViewController {
    func setupUI() {
        view.backgroundColor = .background
        setupBackgroundImageView()
        setupTableView()
        setupConstraints()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 250
        tableView.backgroundColor = .background
        tableView.register(TopMoviesCell.self, forCellReuseIdentifier: "TopMoviesCell")
        
        view.addSubview(tableView)
    }
    
    func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "disney")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        
        view.addSubview(backgroundImageView)
    }
    
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.snp.width).multipliedBy(9.0/16.0)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupGradientMask() {
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = backgroundImageView.bounds
        backgroundImageView.layer.mask = gradientLayer
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopMoviesCell", for: indexPath) as! TopMoviesCell
        cell.configure(data: item.1, top: item.0)
        cell.delegate = self
        return cell
    }
}


// MARK: - MovieActionsDelegate -
extension HomeViewController: MovieActionsDelegate {
    func didLikedMovie(with movieId: Int) {
        presenter.didLikeMovie(withID: movieId)
    }
    
    func didTappedMovie(with movieId: Int) {
        let movieVC = MovieViewController(movieId: movieId)
        navigationController?.pushViewController(movieVC, animated: true)
    }
}

// MARK: - HomeDelegate -
extension HomeViewController: HomeDelegate {
    func configureView(with movies: [(String, [MovieViewData])]) {
        self.movies = movies
        tableView.reloadData()
    }
    
    func showError(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
}

// MARK: - FavoritesUpdateDelegate -
extension HomeViewController: FavoritesUpdateDelegate {
    func didUpdateLikedMovies(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
    
    func showErrorFavoritesUpdate(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
}
