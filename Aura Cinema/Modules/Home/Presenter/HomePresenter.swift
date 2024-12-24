import Foundation

// MARK: - HomeDelegate -
protocol HomeDelegate: FavoritesUpdateDelegate {
    func configureView(with movies: [(String, [MovieViewData])])
    func showError(title: String, message: String, alertType: AlertType)
}

final class HomePresenter {
    private let savedFilmsService = SavedFilmsService.shared
    private let model = HomeModel()
    var delegate: HomeDelegate?
}

@MainActor
extension HomePresenter {
    func fetchMovieData(with fetches: [FetchesMovie]) {
        Task {
            let ids = await getSavedFilms()
            do {
                var arrayMoviesData: [(String, [MovieViewData])] = []
                for fetch in fetches {
                    let movieData = try await model.getMovieData(with: fetch)
                    arrayMoviesData.append((fetch.description, MovieViewData.movies(movieData: movieData, savedFilms: ids)))
                }
                delegate?.configureView(with: arrayMoviesData)
            } catch {
                delegate?.showError(title: String(localized: "loading_error"),
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
                self.delegate?.didUpdateLikedMovies(title: "",
                                                    message: String(localized: "movie_added_to_favorites"),
                                                        alertType: .timed(time: 0.3))
            case .failure(let error):
                let result = self.savedFilmsService.handleError(error: error)
                self.delegate?.showErrorFavoritesUpdate(title: result.title,
                                                            message: result.message,
                                                            alertType: .timed(time: 0.5))
            }
        }
    }
}

private extension HomePresenter {
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
