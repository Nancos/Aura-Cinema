import UIKit

final class DirectoryViewController: UIViewController {
    
    // MARK: = UI Elements -
    private var lastTable: UIView?
    private let collectionMovieView = CollectionMovieView()
    private let filterView = MovieFilterView()
    
    // MARK: = Presenter -
    private let presenter = DirectoryPresenter()
    
    // MARK: = Filtres -
    private var currentCategory: MovieСategoryItems?
    private var currentCountry: [MovieCountryItems]?
    private var currentGenre: [MovieGenreItems]?
    
    // MARK: = Init -
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DirectoryViewController {
    func setupUI() {
        setupView()
        setupFilterView()
        setupCollectionView()
        setupConstraints()
    }
    
    func setupView() {
        view.backgroundColor = .background
        collectionMovieView.delegate = self
        presenter.delegate = self
        presenter.viewDelegate = self
        filterView.delegate = self
    }
    
    func setupFilterView() {
        view.addSubview(filterView)
    }
    
    func setupCollectionView() {
        view.addSubview(collectionMovieView)
    }

    
    func setupConstraints() {
        filterView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(35)
        }
        collectionMovieView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(filterView.snp.bottom).offset(20)
        }
    }
}

extension DirectoryViewController: MovieFilterViewProtocol {
    func didTappedButton(table: UIView, filterId: Int, height: CGFloat) {
        // если открыта эта же таблица закрываем ее
        if let lastTable = lastTable, lastTable == table {
            lastTable.removeFromSuperview()
            self.lastTable = nil
            return
        }
        // если открыта другая таблица, то закрываем ее
        if let lastTable = lastTable {
            lastTable.removeFromSuperview()
        }
        // открываем новую таблицу
        view.addSubview(table)
        setupTableConstraints(for: table, filterId: filterId, height: height)
        // сохраняем текущую таблицу в lastTable
        lastTable = table
    }
    
    func setupTableConstraints(for table: UIView, filterId: Int, height: CGFloat) {
        let leadingOffset = CGFloat(filterId - 1) * (filterView.bounds.width / 3)
        let height = min(height, view.safeAreaLayoutGuide.layoutFrame.height / 2)
        table.snp.remakeConstraints { make in
            make.top.equalTo(filterView.snp.bottom).offset(5)
            make.leading.equalTo(filterView.snp.leading).offset(leadingOffset-15)
            make.width.equalTo(filterView.snp.width).dividedBy(3).offset(30)
            make.height.equalTo(height)
        }
    }
    
    func didChangedFilterCategory(category: MovieСategoryItems?) {
        currentCategory = category
        presenter.fetchMovieData(category: currentCategory, genre: currentGenre, country: currentCountry)
    }
    
    func didChangedFilterCountry(country: [MovieCountryItems]?) {
        currentCountry = country
        presenter.fetchMovieData(category: currentCategory, genre: currentGenre, country: currentCountry)
    }
    
    func didChangedFilterGenre(genre: [MovieGenreItems]?) {
        currentGenre = genre
        presenter.fetchMovieData(category: currentCategory, genre: currentGenre, country: currentCountry)
    }
}

// MARK: - DirectoryViewDelegate -
extension DirectoryViewController: DirectoryViewDelegate {
    func showError(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
    
    func configureCollection(with movies: [MovieViewData]) {
        self.collectionMovieView.configure(with: movies)
    }
}

// MARK: - CollectionMovieViewDelegate -
extension DirectoryViewController: MovieActionsDelegate {
    func didLikedMovie(with movieId: Int) {
        presenter.didLikeMovie(withID: movieId)
    }
    
    func didTappedMovie(with movieId: Int) {
        let movieVC = MovieViewController(movieId: movieId)
        navigationController?.pushViewController(movieVC, animated: true)
    }
}

// MARK: - FavoritesUpdateDelegate - 
extension DirectoryViewController: FavoritesUpdateDelegate {
    
    func didUpdateLikedMovies(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
    
    func showErrorFavoritesUpdate(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
}
