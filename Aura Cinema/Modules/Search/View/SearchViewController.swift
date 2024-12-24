//
//  SearchViewController.swift
//  Aura Cinema
//
//  Created by MacBook Air on 29.12.24.
//

import UIKit

class SearchViewController: UIViewController {
    private let savedFilmsService = SavedFilmsService()
    // MARK: - Presenter -
    var presenter = SearchPresenter()
    // MARK: - UI Elements -
    var collectionMovieView = CollectionMovieView()
    let searchBar = UISearchBar()
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.viewDelegate = self
        collectionMovieView.delegate = self
        setupUI()
    }
}

// MARK: - Private Methods -
private extension SearchViewController {
    func setupUI() {
        setupView()
        setupSearchBar()
        setupCollectionMovieView()
        
        setupConstraints()
    }
    
    func setupView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        view.backgroundColor = .background
    }
    
    func setupSearchBar() {
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .background
        searchBar.layer.cornerRadius = 10
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.systemGray2.cgColor
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search movie..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = true
        searchBar.delegate = self
        
        view.addSubview(searchBar)
    }
    
    func setupCollectionMovieView() {
        
        view.addSubview(collectionMovieView)
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(35)
        }
        collectionMovieView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.height.equalTo(200)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}

// MARK: - UISearchBarDelegate -
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            collectionMovieView.isHidden = true
        } else {
            collectionMovieView.isHidden = false
        }
        didSearch(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - SearchDelegate -
extension SearchViewController: SearchDelegate {
    func showError(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
    
    func didSearch(text: String) {
        presenter.fetchMovieData(with: text)
    }
    
    func configureView(with movies: [MovieViewData]) {
        self.collectionMovieView.configure(with: movies)
    }
}

// MARK: - MovieActionsDelegate -
extension SearchViewController: MovieActionsDelegate {
    func didLikedMovie(with movieId: Int) {
        presenter.didLikeMovie(withID: movieId)
    }
    
    func didTappedMovie(with movieId: Int) {
        let movieVC = MovieViewController(movieId: movieId)
        navigationController?.pushViewController(movieVC, animated: true)
    }
}

extension SearchViewController: FavoritesUpdateDelegate {
    func didUpdateLikedMovies(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
    
    func showErrorFavoritesUpdate(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
}
