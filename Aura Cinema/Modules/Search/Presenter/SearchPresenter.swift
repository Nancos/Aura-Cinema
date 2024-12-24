import UIKit

protocol SearchDelegate {
    func didSearch(text: String)
    func configureView(with movies: [MovieViewData])
    func showError(title: String, message: String, alertType: AlertType)
}

final class SearchPresenter {
    private let savedFilmsService = SavedFilmsService.shared
    private let model = SearchModel()
    var delegate: SearchDelegate?
    var viewDelegate: FavoritesUpdateDelegate?
}

@MainActor
extension SearchPresenter {
    func fetchMovieData(with text: String) {
        Task {
            let ids = await getSavedFilms()
            do {
                let movieData = try await model.getSearchedData(with: text)
                delegate?.configureView(with: MovieViewData.movies(movieData: movieData, savedFilms: ids))
            } catch {
                delegate?.showError(title: String(localized: "loading_error"),
                                    message: String(localized: "error_fetching_movie_card") + "\(error)",
                                    alertType: .standardDefault)
            }
        }
    }
    
    
    func didLikeMovie(withID id: Int){
        savedFilmsService.addSavedFilms(movie: SavedFilmData(id: id)) { [weak self] result in
            
            guard let `self` else { return }
            
            switch result {
            case .success:
                viewDelegate?.didUpdateLikedMovies(title: "",
                                                   message: String(localized: "movie_added_to_favorites"),
                                                   alertType: .timed(time: 0.3))
            case .failure(let failure):
                let result = self.savedFilmsService.handleError(error: failure)
                viewDelegate?.showErrorFavoritesUpdate(title: result.title,
                                                       message: result.message,
                                                       alertType: .timed(time: 0.5))
            }
        }
    }
}

private extension SearchPresenter {
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
