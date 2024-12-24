//
//  LikeViewController.swift
//  Aura Cinema
//
//  Created by MacBook Air on 29.12.24.
//

import UIKit

class LikeViewController: UIViewController {
    
    // MARK: - UI Elements -
    let titleLabel = LabelView()
    var collectionMovieView = CollectionMovieView()
    
    // MARK: - Presnenter -
    let presenter = LikePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        collectionMovieView.delegate = self
        presenter.delegate = self
        presenter.viewDelegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchLikedMovies()
    }
}

private extension LikeViewController {
    func setupUI() {
        setupTitleLabel()
        setupCollectionMovieView()
        
        setupConstraints()
    }
    
    func setupTitleLabel() {
        titleLabel.configure(text: "Сохраненные фильмы: ")
        
        view.addSubview(titleLabel)
    }
    
    func setupCollectionMovieView() {
        view.addSubview(collectionMovieView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(view.bounds.height * 0.045)
        }
        
        collectionMovieView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(20)
        }
    }
}

// MARK: - LikedFilmsDelegate -
extension LikeViewController: LikedFilmsDelegate {
    func showErrorDataAlert(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
    
    func configureView(with movies: [MovieViewData]) {
        self.collectionMovieView.configure(with: movies)
    }
}

// MARK: - MovieActionsDelegate -
extension LikeViewController: MovieActionsDelegate {
    func didLikedMovie(with movieId: Int) {
        presenter.didLikeMovie(withID: movieId)
    }
    
    func didTappedMovie(with movieId: Int) {
        let movieVC = MovieViewController(movieId: movieId)
        navigationController?.pushViewController(movieVC, animated: true)
    }
}

// MARK: - FavoritesUpdateDelegate -
extension LikeViewController: FavoritesUpdateDelegate {
    func didUpdateLikedMovies(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
    
    func showErrorFavoritesUpdate(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
}
