import UIKit

protocol DirectoryViewDelegate {
    func configureCollection(with movies: [MovieViewData])
    func showError(title: String, message: String, alertType: AlertType)
}

final class DirectoryPresenter {
    private let savedFilmsService = SavedFilmsService.shared
    private let model = DirectoryModel()
    var delegate: DirectoryViewDelegate?
    var viewDelegate: FavoritesUpdateDelegate?
    private var queryItems: [URLQueryItem] = []
}

@MainActor
extension DirectoryPresenter {
    func fetchMovieData(category: MovieСategoryItems?, genre: [MovieGenreItems]?, country: [MovieCountryItems]?) {
        let queryItems = createQueryItems(category: category, genre: genre, country: country)
        
        Task {
            let ids = await getSavedFilms()
            do {
                let movieData = try await model.getMoviesData(with: queryItems)
                self.delegate?.configureCollection(with: MovieViewData.movies(movieData: movieData, savedFilms: ids))
            } catch {
                delegate?.showError(title: String(localized: "Error"),
                                    message: String(localized: "error_fetching_movie_card") + "\(error)",
                                    alertType: .standardDefault)
            }
        }
    }
    
    func didLikeMovie(withID id: Int){
        savedFilmsService.addSavedFilms(movie: SavedFilmData(id: id)) { [weak self] result in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success:
                self.viewDelegate?.didUpdateLikedMovies(title: "",
                                                        message: String(localized: "movie_added_to_favorites"),
                                                        alertType: .timed(time: 0.3))
            case .failure(let error):
                let result = self.savedFilmsService.handleError(error: error)
                self.viewDelegate?.showErrorFavoritesUpdate(title: result.title,
                                                            message: result.message,
                                                            alertType: .timed(time: 0.5))
            }
        }
    }
}

private extension DirectoryPresenter {
    func createQueryItems(category: MovieСategoryItems?, genre: [MovieGenreItems]?, country: [MovieCountryItems]?) -> [URLQueryItem] {
        queryItems = []
        
        if let category {
            let categoryQueryItem = URLQueryItem(name: "type", value: category.rawValue)
            queryItems.append(categoryQueryItem)
        }
        
        if let genre {
            for genreItem in genre {
                let genreQueryItem = URLQueryItem(name: "genres.name", value: genreItem.rawValue)
                queryItems.append(genreQueryItem)
            }
        }
        
        if let country {
            for countryItem in country {
                let countryQueryItem = URLQueryItem(name: "countries.name", value: countryItem.rawValue)
                queryItems.append(countryQueryItem)
            }
        }
        return queryItems
    }
    
    func getSavedFilms() async -> [Int] {
        return await withCheckedContinuation { continuation in
            savedFilmsService.loadSavedFilms() { result in
                switch result {
                case .success(let films):
                    let ids = films.map(\.id)
                    continuation.resume(returning: ids)
                case .failure(_):
                    continuation.resume(returning: [])
                }
            }
        }
    }
}
